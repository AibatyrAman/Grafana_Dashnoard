# 🚀 Railway ile Grafana Canlıya Alma Rehberi (Güncellenmiş)

## 📋 Gereksinimler
- GitHub hesabı
- Railway hesabı (ücretsiz)

## 🎯 Adım Adım Deployment

### 1. GitHub'a Yükleme
```bash
# Git repository oluştur
git init
git add .
git commit -m "Grafana project ready for Railway deployment"
git branch -M main
git remote add origin https://github.com/KULLANICI_ADI/grafana-project.git
git push -u origin main
```

### 2. Railway'e Bağlama
1. [Railway.app](https://railway.app) adresine git
2. "Login with GitHub" ile giriş yap
3. "New Project" butonuna tıkla
4. "Deploy from GitHub repo" seç
5. Repository'nizi seçin

### 3. Environment Variables Ayarlama
Railway dashboard'da "Variables" sekmesine gidin ve şunları ekleyin:

**Zorunlu:**
- `GF_SECURITY_ADMIN_USER` = `admin`
- `GF_SECURITY_ADMIN_PASSWORD` = `Admin123` (veya güçlü şifre)
- `GF_SECURITY_SECRET_KEY` = `MySecretKey12345`

**Opsiyonel:**
- `GF_LOG_LEVEL` = `info`
- `GF_ANALYTICS_REPORTING_ENABLED` = `false`

### 4. Deployment
Railway otomatik olarak:
- ✅ Dockerfile'ı bulacak
- ✅ Port'u ayarlayacak
- ✅ SSL sertifikası ekleyecek
- ✅ Domain verecek

## 🌐 Erişim
Deployment tamamlandıktan sonra:
- Railway size otomatik domain verecek
- Örnek: `https://grafana-production-xxxx.up.railway.app`
- Giriş: `admin` / `Admin123`

## 🔧 Alternatif: Render.com

### 1. Render'e Yükleme
1. [Render.com](https://render.com) adresine git
2. "Get Started for Free" ile kayıt ol
3. "New +" → "Web Service"
4. GitHub repository'nizi bağla

### 2. Konfigürasyon
- **Build Command:** `docker-compose -f docker-compose.railway.yml build`
- **Start Command:** `docker-compose -f docker-compose.railway.yml up`
- **Environment:** `Docker`

## 🆓 Ücretsiz Limitler

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

## 🚨 Önemli Notlar

1. **Şifre Değiştirin:** Production'da güçlü şifre kullanın
2. **Backup:** Verilerinizi düzenli yedekleyin
3. **Monitoring:** Ücretsiz limitleri takip edin
4. **Domain:** Custom domain ekleyebilirsiniz

## 🔗 Faydalı Linkler
- [Railway Documentation](https://docs.railway.app/)
- [Render Documentation](https://render.com/docs)
- [Grafana Documentation](https://grafana.com/docs/)

## 📞 Destek
Sorun yaşarsanız:
1. Logları kontrol edin
2. Environment variables'ları kontrol edin
3. Port ayarlarını kontrol edin
