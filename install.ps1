# insurance-moments 豆包一键安装脚本
# 用法：irm https://raw.githubusercontent.com/qingmuke/insurance-moments/main/install.ps1 | iex

$ErrorActionPreference = "Stop"

Write-Host "=== insurance-moments v3.0 安装器 ===" -ForegroundColor Cyan
Write-Host ""

# 1. 确定豆包 user_skills 目录
$userName = $env:USERNAME
$skillsDir = "C:\Users\$userName\AppData\Local\Doubao\User Data\Profile 1\.doubao\agent_mode\workspace\.user_skills"

if (-not (Test-Path $skillsDir)) {
    Write-Host "未检测到豆包 user_skills 目录，尝试创建..." -ForegroundColor Yellow
    New-Item -ItemType Directory -Path $skillsDir -Force | Out-Null
}

$targetDir = Join-Path $skillsDir "insurance-moments"

# 2. 如果已存在，先备份旧版本
if (Test-Path $targetDir) {
    $backupDir = "$targetDir.backup.$(Get-Date -Format 'yyyyMMddHHmmss')"
    Write-Host "检测到旧版本，已备份到: $backupDir" -ForegroundColor Yellow
    Move-Item $targetDir $backupDir
}

# 3. 从 GitHub 下载 skill 文件
$tempDir = Join-Path $env:TEMP "insurance-moments-install"
if (Test-Path $tempDir) { Remove-Item -Recurse -Force $tempDir }
New-Item -ItemType Directory -Path $tempDir -Force | Out-Null

$baseUrl = "https://raw.githubusercontent.com/qingmuke/insurance-moments/main/skills/insurance-moments"

Write-Host "正在下载 SKILL.md..." -ForegroundColor Gray
Invoke-WebRequest -Uri "$baseUrl/SKILL.md" -OutFile "$tempDir\SKILL.md" -UseBasicParsing

Write-Host "正在下载 references/voice-profiles.md..." -ForegroundColor Gray
New-Item -ItemType Directory -Path "$tempDir\references" -Force | Out-Null
Invoke-WebRequest -Uri "$baseUrl/references/voice-profiles.md" -OutFile "$tempDir\references\voice-profiles.md" -UseBasicParsing

Write-Host "正在下载 references/compliance-check.md..." -ForegroundColor Gray
Invoke-WebRequest -Uri "$baseUrl/references/compliance-check.md" -OutFile "$tempDir\references\compliance-check.md" -UseBasicParsing

# 4. 复制到目标目录
Copy-Item -Recurse $tempDir $targetDir

# 5. 清理临时文件
Remove-Item -Recurse -Force $tempDir

# 6. 验证安装
if (Test-Path "$targetDir\SKILL.md") {
    Write-Host ""
    Write-Host "=== 安装成功！===" -ForegroundColor Green
    Write-Host "安装位置: $targetDir" -ForegroundColor Green
    Write-Host ""
    Write-Host "请重启豆包后使用。" -ForegroundColor Cyan
    Write-Host "使用方法: 直接丢一句保险素材给豆包，比如" -ForegroundColor Gray
    Write-Host '  "爱是从青丝到白发都能护你体面周全，这就是终身护理险"' -ForegroundColor Gray
} else {
    Write-Host "安装失败，请检查网络连接后重试。" -ForegroundColor Red
    exit 1
}
