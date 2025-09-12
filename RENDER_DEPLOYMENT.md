# 🚀 Render.com ile Grafana Canlıya Alma Rehberi

## 📋 Gereksinimler
- GitHub hesabı
- Render.com hesabı (ücretsiz)

## 🎯 Adım Adım Deployment

### 1. GitHub'a Yükleme
```bash
# Git repository oluştur
git init
git add .
git commit -m "Grafana project ready for Render deployment"
git branch -M main
git remote add origin https://github.com/KULLANICI_ADI/grafana-project.git
git push -u origin main
```

### 2. Render'e Bağlama
1. [Render.com](https://render.com) adresine git
2. "Get Started for Free" ile kayıt ol
3. "New +" → "Web Service" seç
4. GitHub repository'nizi bağla

### 3. Konfigürasyon
**Build & Deploy:**
- **Environment:** `Docker`
- **Dockerfile Path:** `Dockerfile.render`
- **Build Command:** (boş bırak)
- **Start Command:** (boş bırak)

### 4. Environment Variables
Render dashboard'da "Environment" sekmesine gidin:

**Zorunlu:**
- `GF_SECURITY_ADMIN_USER` = `admin`
- `GF_SECURITY_ADMIN_PASSWORD` = `Admin123`
- `GF_SECURITY_SECRET_KEY` = `MySecretKey12345`

**Otomatik (Render tarafından sağlanır):**
- `RENDER_EXTERNAL_URL` = Otomatik domain
- `PORT` = 3000

### 5. Deployment
Render otomatik olarak:
- ✅ Dockerfile'ı build edecek
- ✅ Port'u ayarlayacak
- ✅ SSL sertifikası ekleyecek
- ✅ Domain verecek

## 🌐 Erişim
Deployment tamamlandıktan sonra:
- Render size otomatik domain verecek
- Örnek: `https://grafana-xxxx.onrender.com`
- Giriş: `admin` / `Admin123`

## 🆓 Ücretsiz Limitler
- ✅ 750 saat/ay ücretsiz
- ✅ SSL otomatik
- ✅ Custom domain
- ✅ 512MB RAM

## 🔧 Troubleshooting
**Build Hatası Alırsanız:**
1. `Dockerfile.render` kullandığınızdan emin olun
2. Environment variables'ları kontrol edin
3. Logları kontrol edin

**Erişim Sorunu:**
1. Domain'in aktif olduğunu kontrol edin
2. Port ayarlarını kontrol edin
3. Health check endpoint'ini test edin: `/api/health`
