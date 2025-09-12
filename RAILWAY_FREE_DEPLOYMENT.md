# Railway Ücretsiz Grafana Deployment Rehberi

Bu rehber, Grafana'yı Railway'in ücretsiz planında nasıl deploy edeceğinizi gösterir.

## Sorun ve Çözüm

**Sorun:** Railway'de Grafana healthcheck hatası alıyordunuz çünkü:
1. External datasource'lar (Prometheus, InfluxDB, MySQL) mevcut değildi
2. Healthcheck timeout'u çok kısaydı
3. curl komutu container'da yüklü değildi

**Çözüm:** 
- TestData datasource kullanarak standalone Grafana
- Artırılmış healthcheck timeout
- curl yüklü Dockerfile
- Basit sample dashboard

## Railway'de Deploy Etme

### 1. Railway'e Giriş
- [Railway.app](https://railway.app) adresine gidin
- GitHub hesabınızla giriş yapın

### 2. Yeni Proje Oluşturma
- "New Project" butonuna tıklayın
- "Deploy from GitHub repo" seçin
- Bu repository'yi seçin

### 3. Environment Variables
Railway dashboard'da aşağıdaki environment variables'ları ekleyin:

```
GF_SECURITY_ADMIN_USER=admin
GF_SECURITY_ADMIN_PASSWORD=Admin123
GF_SECURITY_SECRET_KEY=MySecretKey12345
GF_ANALYTICS_REPORTING_ENABLED=false
GF_ANALYTICS_CHECK_FOR_UPDATES=false
GF_LOG_LEVEL=info
GF_DATABASE_TYPE=sqlite3
GF_SESSION_PROVIDER=memory
GF_USERS_ALLOW_SIGN_UP=false
GF_USERS_ALLOW_ORG_CREATE=false
GF_AUTH_ANONYMOUS_ENABLED=false
```

### 4. Deploy
- Railway otomatik olarak Dockerfile'ı kullanarak deploy edecek
- Build işlemi 2-3 dakika sürebilir
- Healthcheck artık başarılı olacak

## Grafana'ya Erişim

1. Railway dashboard'da "View Logs" ile deployment durumunu kontrol edin
2. "Settings" > "Domains" bölümünden public URL'i alın
3. `https://your-app.railway.app` adresine gidin
4. Username: `admin`, Password: `Admin123` ile giriş yapın

## Özellikler

- ✅ Ücretsiz Railway planında çalışır
- ✅ TestData datasource ile sample dashboard
- ✅ SQLite database (persistent storage)
- ✅ Otomatik healthcheck
- ✅ HTTPS desteği

## Sonraki Adımlar

1. **Gerçek Datasource Ekleme:** Railway'de ayrı bir service olarak Prometheus/InfluxDB deploy edebilirsiniz
2. **Custom Dashboard:** Kendi dashboard'larınızı oluşturun
3. **Authentication:** LDAP/OAuth entegrasyonu ekleyin
4. **Monitoring:** Uptime monitoring için external service kullanın

## Troubleshooting

**Hala healthcheck hatası alıyorsanız:**
1. Railway logs'u kontrol edin
2. Environment variables'ların doğru eklendiğinden emin olun
3. Build log'larında hata var mı kontrol edin

**Grafana açılmıyorsa:**
1. URL'in doğru olduğundan emin olun
2. Browser cache'ini temizleyin
3. Incognito mode'da deneyin
