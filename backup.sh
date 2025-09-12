#!/bin/bash

# Grafana Backup Script
# Bu script Grafana verilerini yedekler

set -e

# Konfigürasyon
BACKUP_DIR="./backups"
DATE=$(date +%Y%m%d_%H%M%S)
CONTAINER_NAME="grafana"
BACKUP_FILE="grafana_backup_${DATE}.tar.gz"

# Backup dizinini oluştur
mkdir -p "$BACKUP_DIR"

echo "Grafana backup başlatılıyor..."

# Container'ın çalıştığını kontrol et
if ! docker ps | grep -q "$CONTAINER_NAME"; then
    echo "Hata: $CONTAINER_NAME container'ı çalışmıyor!"
    exit 1
fi

# Grafana verilerini yedekle
echo "Veri yedekleme işlemi başlatılıyor..."
docker exec "$CONTAINER_NAME" tar -czf /tmp/backup.tar.gz -C /var/lib/grafana .
docker cp "$CONTAINER_NAME:/tmp/backup.tar.gz" "$BACKUP_DIR/$BACKUP_FILE"
docker exec "$CONTAINER_NAME" rm /tmp/backup.tar.gz

# Konfigürasyon dosyalarını yedekle
echo "Konfigürasyon dosyaları yedekleniyor..."
tar -czf "$BACKUP_DIR/config_backup_${DATE}.tar.gz" \
    docker-compose.yml \
    docker-compose.prod.yml \
    nginx.conf \
    prometheus.yml \
    grafana/

# Eski yedekleri temizle (30 günden eski)
echo "Eski yedekler temizleniyor..."
find "$BACKUP_DIR" -name "*.tar.gz" -mtime +30 -delete

echo "Backup tamamlandı: $BACKUP_DIR/$BACKUP_FILE"
echo "Konfigürasyon yedeği: $BACKUP_DIR/config_backup_${DATE}.tar.gz"

# Backup boyutunu göster
ls -lh "$BACKUP_DIR/$BACKUP_FILE"
ls -lh "$BACKUP_DIR/config_backup_${DATE}.tar.gz"
