# Grafana Backup Script (PowerShell)
# Bu script Grafana verilerini yedekler

param(
    [string]$BackupDir = ".\backups",
    [string]$ContainerName = "grafana"
)

# Hata durumunda dur
$ErrorActionPreference = "Stop"

# Tarih formatı
$Date = Get-Date -Format "yyyyMMdd_HHmmss"
$BackupFile = "grafana_backup_$Date.tar.gz"
$ConfigBackupFile = "config_backup_$Date.tar.gz"

# Backup dizinini oluştur
if (!(Test-Path $BackupDir)) {
    New-Item -ItemType Directory -Path $BackupDir -Force
}

Write-Host "Grafana backup başlatılıyor..." -ForegroundColor Green

# Container'ın çalıştığını kontrol et
$ContainerStatus = docker ps --filter "name=$ContainerName" --format "{{.Names}}"
if ($ContainerStatus -ne $ContainerName) {
    Write-Host "Hata: $ContainerName container'ı çalışmıyor!" -ForegroundColor Red
    exit 1
}

try {
    # Grafana verilerini yedekle
    Write-Host "Veri yedekleme işlemi başlatılıyor..." -ForegroundColor Yellow
    docker exec $ContainerName tar -czf /tmp/backup.tar.gz -C /var/lib/grafana .
    docker cp "$ContainerName`:/tmp/backup.tar.gz" "$BackupDir\$BackupFile"
    docker exec $ContainerName rm /tmp/backup.tar.gz

    # Konfigürasyon dosyalarını yedekle
    Write-Host "Konfigürasyon dosyaları yedekleniyor..." -ForegroundColor Yellow
    
    # 7-Zip kullanarak arşiv oluştur (eğer yüklüyse)
    if (Get-Command "7z" -ErrorAction SilentlyContinue) {
        7z a -ttar "$BackupDir\$ConfigBackupFile" docker-compose.yml docker-compose.prod.yml nginx.conf prometheus.yml grafana\
    } else {
        # PowerShell ile basit arşiv oluştur
        $Files = @("docker-compose.yml", "docker-compose.prod.yml", "nginx.conf", "prometheus.yml", "grafana")
        $Files | ForEach-Object {
            if (Test-Path $_) {
                Copy-Item $_ -Destination "$BackupDir\config_$Date\" -Recurse -Force
            }
        }
    }

    # Eski yedekleri temizle (30 günden eski)
    Write-Host "Eski yedekler temizleniyor..." -ForegroundColor Yellow
    Get-ChildItem $BackupDir -Filter "*.tar.gz" | Where-Object { $_.LastWriteTime -lt (Get-Date).AddDays(-30) } | Remove-Item -Force

    Write-Host "Backup tamamlandı!" -ForegroundColor Green
    Write-Host "Veri yedeği: $BackupDir\$BackupFile" -ForegroundColor Cyan
    Write-Host "Konfigürasyon yedeği: $BackupDir\$ConfigBackupFile" -ForegroundColor Cyan

    # Backup boyutunu göster
    if (Test-Path "$BackupDir\$BackupFile") {
        $Size = (Get-Item "$BackupDir\$BackupFile").Length
        Write-Host "Backup boyutu: $([math]::Round($Size/1MB, 2)) MB" -ForegroundColor Magenta
    }

} catch {
    Write-Host "Backup sırasında hata oluştu: $($_.Exception.Message)" -ForegroundColor Red
    exit 1
}
