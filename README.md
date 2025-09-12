# 🚀 Grafana Docker Project

Bu proje, Grafana'yı Docker ile production ortamında çalıştırmak için hazırlanmıştır.

## 📋 Özellikler

- ✅ **Docker Compose** ile kolay kurulum
- ✅ **Production ready** konfigürasyon
- ✅ **Railway & Render** deployment desteği
- ✅ **SSL** otomatik yapılandırma
- ✅ **Backup** scriptleri
- ✅ **Monitoring** desteği

## 🚀 Hızlı Başlangıç

### Lokal Çalıştırma
```bash
# Grafana'yı başlat
docker-compose -f docker_compose.yml up -d

# Erişim
http://localhost:3001
# Kullanıcı: admin
# Şifre: Admin123
```

### Production Deployment

#### Railway.com
1. [Railway.app](https://railway.app) adresine gidin
2. GitHub ile giriş yapın
3. "New Project" → "Deploy from GitHub repo"
4. Bu repository'yi seçin
5. Environment variables ekleyin:
   - `GF_SECURITY_ADMIN_USER` = `admin`
   - `GF_SECURITY_ADMIN_PASSWORD` = `Admin123`
   - `GF_SECURITY_SECRET_KEY` = `MySecretKey12345`

#### Render.com
1. [Render.com](https://render.com) adresine gidin
2. "Get Started for Free" ile kayıt olun
3. "New +" → "Web Service"
4. GitHub repository'nizi bağlayın
5. **Environment:** `Docker`
6. **Dockerfile Path:** `Dockerfile.render`

## 📁 Proje Yapısı

```
grafana_docker_project/
├── docker_compose.yml          # Lokal development
├── docker-compose.prod.yml     # Production (Nginx + SSL)
├── docker-compose.railway.yml  # Railway deployment
├── Dockerfile                  # Railway için
├── Dockerfile.render           # Render.com için
├── nginx.conf                  # Reverse proxy
├── prometheus.yml              # Monitoring
├── grafana/
│   ├── provisioning/           # Otomatik konfigürasyon
│   └── dashboards/             # Dashboard dosyaları
├── backup.ps1                  # Windows backup script
├── backup.sh                   # Linux backup script
└── README.md                   # Bu dosya
```

## 🔧 Konfigürasyon

### Environment Variables
```bash
# Admin kullanıcı
GF_SECURITY_ADMIN_USER=admin
GF_SECURITY_ADMIN_PASSWORD=Admin123

# Güvenlik
GF_SECURITY_SECRET_KEY=MySecretKey12345

# Domain (production için)
GF_SERVER_DOMAIN=your-domain.com
GF_SERVER_ROOT_URL=https://your-domain.com
```

### Dashboard Import
1. Grafana'ya giriş yapın
2. **"+" → "Import"** seçin
3. JSON dosyasını upload edin

## 🆓 Ücretsiz Hosting

### Railway
- ✅ 500 saat/ay ücretsiz
- ✅ SSL otomatik
- ✅ Custom domain
- ✅ 512MB RAM

### Render
- ✅ 750 saat/ay ücretsiz
- ✅ SSL otomatik
- ✅ Custom domain
- ✅ 512MB RAM

## 📚 Dokümantasyon

- [Railway Deployment Guide](RAILWAY_DEPLOYMENT.md)
- [Render Deployment Guide](RENDER_DEPLOYMENT.md)
- [Production Deployment Guide](DEPLOYMENT_GUIDE.md)

## 🔗 Faydalı Linkler

- [Grafana Documentation](https://grafana.com/docs/)
- [Docker Compose Documentation](https://docs.docker.com/compose/)
- [Railway Documentation](https://docs.railway.app/)
- [Render Documentation](https://render.com/docs)

## 📞 Destek

Sorun yaşarsanız:
1. Log dosyalarını kontrol edin
2. Environment variables'ları kontrol edin
3. Health check endpoint'ini test edin: `/api/health`

## 📄 Lisans

Bu proje MIT lisansı altında lisanslanmıştır.
