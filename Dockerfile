# Railway için Basit Grafana Dockerfile
FROM grafana/grafana:latest

# Port 3000'i expose et
EXPOSE 3000

# Railway PORT environment variable'ını kullan
ENV GF_SERVER_HTTP_PORT=3000
ENV GF_SERVER_DOMAIN=${RAILWAY_PUBLIC_DOMAIN}
ENV GF_SERVER_ROOT_URL=https://${RAILWAY_PUBLIC_DOMAIN}

# Grafana'yı başlat
CMD ["grafana-server", "--config=/etc/grafana/grafana.ini"]
