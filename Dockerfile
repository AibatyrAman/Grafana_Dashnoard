# Railway için Basit Grafana Dockerfile
FROM grafana/grafana:latest

# curl'ü yükle (healthcheck için gerekli)
USER root
RUN apk add --no-cache curl
USER grafana

# Port 3000'i expose et
EXPOSE 3000

# Railway PORT environment variable'ını kullan
ENV GF_SERVER_HTTP_PORT=3000
ENV GF_SERVER_DOMAIN=${RAILWAY_PUBLIC_DOMAIN}
ENV GF_SERVER_ROOT_URL=https://${RAILWAY_PUBLIC_DOMAIN}

# Grafana konfigürasyonu - Railway için optimize edilmiş
ENV GF_SECURITY_ADMIN_USER=admin
ENV GF_SECURITY_ADMIN_PASSWORD=Admin123
ENV GF_SECURITY_SECRET_KEY=MySecretKey12345
ENV GF_ANALYTICS_REPORTING_ENABLED=false
ENV GF_ANALYTICS_CHECK_FOR_UPDATES=false
ENV GF_LOG_LEVEL=debug
ENV GF_DATABASE_TYPE=sqlite3
ENV GF_SESSION_PROVIDER=memory
ENV GF_USERS_ALLOW_SIGN_UP=false
ENV GF_USERS_ALLOW_ORG_CREATE=false
ENV GF_AUTH_ANONYMOUS_ENABLED=false
ENV GF_SERVER_ENABLE_GZIP=true
ENV GF_SERVER_SERVE_FROM_SUB_PATH=false
ENV GF_PATHS_DATA=/var/lib/grafana
ENV GF_PATHS_LOGS=/var/log/grafana
ENV GF_PATHS_PLUGINS=/var/lib/grafana/plugins
ENV GF_PATHS_PROVISIONING=/etc/grafana/provisioning

# Provisioning dosyalarını kopyala
COPY grafana/provisioning /etc/grafana/provisioning
COPY grafana/dashboards /var/lib/grafana/dashboards

# Grafana'yı başlat - debug mode ile
CMD ["grafana-server", "--config=/etc/grafana/grafana.ini", "--log-level=debug"]
