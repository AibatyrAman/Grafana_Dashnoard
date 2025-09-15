#!/bin/bash

# Railway Log Analiz Script'i
echo "=========================================="
echo "📊 Railway Grafana Log Analizi"
echo "=========================================="

# Log dosyası kontrolü
if [ ! -f "logs.1757910515917.json" ]; then
    echo "❌ Log dosyası bulunamadı: logs.1757910515917.json"
    exit 1
fi

echo "📁 Log dosyası bulundu: logs.1757910515917.json"
echo ""

# JSON log'ları analiz et
echo "🔍 Log Analizi:"
echo "=========================================="

# Build süresi
BUILD_TIME=$(jq -r '.[] | select(.message | contains("Build time")) | .message' logs.1757910515917.json)
if [ "$BUILD_TIME" != "null" ]; then
    echo "⏱️  Build Süresi: $BUILD_TIME"
fi

# Healthcheck durumu
HEALTHCHECK_ATTEMPTS=$(jq -r '.[] | select(.message | contains("Attempt")) | .message' logs.1757910515917.json | wc -l)
echo "🔍 Healthcheck Deneme Sayısı: $HEALTHCHECK_ATTEMPTS"

# Son hata mesajı
LAST_ERROR=$(jq -r '.[] | select(.message | contains("failed") or contains("error") or contains("Error")) | .message' logs.1757910515917.json | tail -1)
if [ "$LAST_ERROR" != "null" ] && [ "$LAST_ERROR" != "" ]; then
    echo "❌ Son Hata: $LAST_ERROR"
fi

# Başarılı build kontrolü
BUILD_SUCCESS=$(jq -r '.[] | select(.message | contains("Build time")) | .message' logs.1757910515917.json)
if [ "$BUILD_SUCCESS" != "null" ]; then
    echo "✅ Build Başarılı"
else
    echo "❌ Build Başarısız"
fi

# Healthcheck başarısızlığı
HEALTHCHECK_FAILED=$(jq -r '.[] | select(.message | contains("Healthcheck failed")) | .message' logs.1757910515917.json)
if [ "$HEALTHCHECK_FAILED" != "null" ]; then
    echo "❌ Healthcheck Başarısız: $HEALTHCHECK_FAILED"
fi

echo ""
echo "📋 Öneriler:"
echo "=========================================="

if [ "$HEALTHCHECK_ATTEMPTS" -gt 10 ]; then
    echo "🔧 Healthcheck çok fazla deneme yapıyor - Port veya endpoint sorunu olabilir"
fi

if [ "$BUILD_SUCCESS" = "null" ]; then
    echo "🔧 Build başarısız - Dockerfile veya dependency sorunu olabilir"
fi

echo "💡 Railway dashboard'da 'Logs' sekmesinden detaylı logları kontrol edin"
echo "💡 Environment variables'ları kontrol edin"
echo "💡 Port ayarlarını kontrol edin"

echo ""
echo "=========================================="
echo "✅ Log analizi tamamlandı"
echo "=========================================="
