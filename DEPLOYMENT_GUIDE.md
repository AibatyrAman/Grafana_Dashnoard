# Grafana Production Deployment Rehberi

Bu rehber, Grafana'yı Docker ile production ortamında canlıya almak için gerekli adımları içerir.

## 🚀 Hızlı Başlangıç

### 1. Gereksinimler
- Docker ve Docker Compose yüklü olmalı
- Domain adınız hazır olmalı
- SSL sertifikası (Let's Encrypt önerilir)

### 2. Environment Değişkenleri
`.env` dosyası oluşturun ve aşağıdaki değerleri ayarlayın:

```bash
# Admin kullanıcı bilgileri
GRAFANA_ADMIN_USER=admin
GRAFANA_ADMIN_PASSWORD=GüçlüŞifre123!

# Grafana güvenlik anahtarı (rastgele 16 karakter)
GRAFANA_SECRET_KEY=MySecretKey12345

# Domain ayarları
GRAFANA_DOMAIN=your-domain.com
GRAFANA_ROOT_URL=https://your-domain.com
```

### 3. SSL Sertifikası
SSL klasörü oluşturun ve sertifikalarınızı yerleştirin:
```bash
mkdir ssl
# Sertifikalarınızı ssl/ klasörüne kopyalayın
# grafana.crt ve grafana.key dosyaları
```

### 4. Deployment
```bash
# Production ortamında çalıştır
docker-compose -f docker-compose.prod.yml up -d

# Monitoring ile birlikte çalıştır
docker-compose -f docker-compose.prod.yml --profile monitoring up -d
```

## 🔧 Detaylı Konfigürasyon

### Güvenlik Ayarları
- Admin şifresi güçlü olmalı
- SSL sertifikası kullanılmalı
- Firewall kuralları ayarlanmalı
- Rate limiting aktif

### Monitoring
Prometheus ve Node Exporter ile sistem izleme:
```bash
# Monitoring servislerini başlat
docker-compose -f docker-compose.prod.yml --profile monitoring up -d
```

### Backup
Veri yedekleme için:
```bash
# Linux/Mac
./backup.sh

# Windows PowerShell
.\backup.ps1
```

## 🌐 Domain ve DNS Ayarları

### DNS Kayıtları
```
A    your-domain.com        -> SERVER_IP
A    www.your-domain.com    -> SERVER_IP
```

### Nginx Konfigürasyonu
`nginx.conf` dosyasında domain adınızı güncelleyin:
```nginx
server_name your-domain.com www.your-domain.com;
```

## 📊 Grafana Konfigürasyonu

### Datasource'lar
`grafana/provisioning/datasources/datasources.yml` dosyasında:
- Prometheus
- InfluxDB
- MySQL

### Dashboard'lar
`grafana/dashboards/` klasörüne dashboard JSON dosyalarınızı ekleyin.

## 🔍 Troubleshooting

### Log Kontrolü
```bash
# Grafana logları
docker logs grafana

# Nginx logları
docker logs grafana_nginx

# Tüm servislerin durumu
docker-compose -f docker-compose.prod.yml ps
```

### Health Check
```bash
# Grafana health check
curl http://localhost:3000/api/health

# Nginx health check
curl http://localhost/health
```

### Port Kontrolü
```bash
# Kullanılan portları kontrol et
netstat -tulpn | grep :80
netstat -tulpn | grep :443
netstat -tulpn | grep :3000
```

## 🚨 Güvenlik Kontrol Listesi

- [ ] Güçlü admin şifresi
- [ ] SSL sertifikası aktif
- [ ] Firewall kuralları
- [ ] Rate limiting aktif
- [ ] Security headers
- [ ] Anonymous access kapalı
- [ ] User signup kapalı
- [ ] Gravatar kapalı

## 📈 Performance Optimizasyonu

### Nginx Ayarları
- Gzip compression aktif
- Buffer ayarları optimize
- Connection timeout'ları ayarlanmış

### Grafana Ayarları
- Database optimizasyonu
- Session management
- Cache ayarları

## 🔄 Güncelleme

### Grafana Güncelleme
```bash
# Yeni image'ı çek
docker-compose -f docker-compose.prod.yml pull

# Servisleri yeniden başlat
docker-compose -f docker-compose.prod.yml up -d
```

### Backup'tan Geri Yükleme
```bash
# Backup dosyasını çıkar
tar -xzf grafana_backup_YYYYMMDD_HHMMSS.tar.gz

# Container'ı durdur
docker-compose -f docker-compose.prod.yml down

# Verileri geri yükle
docker run --rm -v grafana_docker_project_grafana_data:/data -v $(pwd):/backup alpine tar -xzf /backup/grafana_backup_YYYYMMDD_HHMMSS.tar.gz -C /data

# Servisleri başlat
docker-compose -f docker-compose.prod.yml up -d
```

## 📞 Destek

Sorun yaşarsanız:
1. Log dosyalarını kontrol edin
2. Health check'leri çalıştırın
3. Port ve network ayarlarını kontrol edin
4. SSL sertifikalarını doğrulayın

## 🔗 Faydalı Linkler

- [Grafana Documentation](https://grafana.com/docs/)
- [Docker Compose Documentation](https://docs.docker.com/compose/)
- [Nginx Documentation](https://nginx.org/en/docs/)
- [Let's Encrypt](https://letsencrypt.org/)
