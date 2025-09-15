#!/bin/sh

# Railway Log Tutma Script'i
echo "=========================================="
echo "🚀 Grafana Railway Deployment Başlatılıyor"
echo "=========================================="
echo "📅 Tarih: $(date)"
echo "🌍 Environment: Railway"
echo "🔧 Port: ${PORT:-3000}"
echo "👤 Admin User: ${GF_SECURITY_ADMIN_USER:-admin}"
echo "=========================================="

# Grafana log dosyası oluştur
mkdir -p /var/log/grafana
touch /var/log/grafana/grafana.log

# Grafana'yı arka planda başlat
echo "🔄 Grafana servisi başlatılıyor..."
grafana-server > /var/log/grafana/grafana.log 2>&1 &
GRAFANA_PID=$!

echo "✅ Grafana PID: $GRAFANA_PID"
echo "📝 Log dosyası: /var/log/grafana/grafana.log"

# Healthcheck fonksiyonu
healthcheck() {
    echo "🔍 Healthcheck yapılıyor..."
    if curl -f http://localhost:${PORT:-3000}/api/health > /dev/null 2>&1; then
        echo "✅ Grafana sağlıklı - Healthcheck başarılı"
        return 0
    else
        echo "❌ Grafana sağlıksız - Healthcheck başarısız"
        return 1
    fi
}

# İlk healthcheck için bekle
echo "⏳ Grafana'nın başlaması için 10 saniye bekleniyor..."
sleep 10

# Healthcheck döngüsü
HEALTHCHECK_COUNT=0
MAX_HEALTHCHECKS=30

while [ $HEALTHCHECK_COUNT -lt $MAX_HEALTHCHECKS ]; do
    if healthcheck; then
        echo "🎉 Grafana başarıyla başlatıldı!"
        break
    else
        HEALTHCHECK_COUNT=$((HEALTHCHECK_COUNT + 1))
        echo "⏳ Healthcheck $HEALTHCHECK_COUNT/$MAX_HEALTHCHECKS - 5 saniye bekleniyor..."
        sleep 5
    fi
done

if [ $HEALTHCHECK_COUNT -eq $MAX_HEALTHCHECKS ]; then
    echo "❌ Grafana başlatılamadı - Maksimum healthcheck sayısına ulaşıldı"
    echo "📋 Son loglar:"
    tail -20 /var/log/grafana/grafana.log
    exit 1
fi

# Log monitoring
echo "📊 Log monitoring başlatılıyor..."
echo "=========================================="

# Grafana loglarını takip et
tail -f /var/log/grafana/grafana.log &
TAIL_PID=$!

# Ana process'i bekle
wait $GRAFANA_PID
