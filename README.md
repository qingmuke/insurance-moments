# insurance-moments

保险经纪人朋友圈文案生成器 v3.0。给一句保险素材，先通过两三轮对话挖你的真实想法，再出 6 条文案（3 条大咖原版 + 3 条合规版），口吻覆盖刘润、李笑来、黄执中。

## 安装

### 方式一：豆包对话内一键安装（推荐，小白专用）

**不需要打开 PowerShell，不需要懂命令行。** 只需要把下面这段话复制下来，直接发给豆包，豆包会自动下载并安装好：

```
帮我安装 insurance-moments 这个 skill。从这个地址下载 zip 包：https://github.com/qingmuke/insurance-moments/archive/refs/heads/main.zip，解压后把里面 skills 文件夹下的 insurance-moments 文件夹，整个复制到豆包的 user_skills 目录里。装完告诉我。
```

豆包收到后会自动完成下载、解压、复制，然后告诉你"安装完成，重启豆包即可使用"。

> 注意：把上面链接里的「qingmuke」替换成这个仓库主人的 GitHub 用户名。

### 方式二：PowerShell 一键安装（适合想自己跑命令的人）

把下面的代码复制保存为 `install.ps1`，然后右键用 PowerShell 运行：

```powershell
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

```

### 方式三：Claude Code / Cursor / Codex 等工具

```bash
npx -y skills add qingmuke/insurance-moments -g --skill insurance-moments
```

### 方式四：手动安装（所有平台通用）

1. 点本页面右上角绿色 **Code** 按钮 → **Download ZIP**
2. 解压 zip，找到里面的 `skills/insurance-moments` 文件夹
3. 把这个文件夹复制到对应工具的 skills 目录：
   - **豆包 Windows**：`C:\Users\qingmuke\AppData\Local\Doubao\User Data\Profile 1\.doubao\agent_mode\workspace\.user_skills\`
   - **Claude Code**：`~/.claude/skills/`
   - **Cursor**：`~/.cursor/skills/`
   - **Codex**：`~/.codex/skills/`
4. 重启工具

## 使用方法

安装并重启豆包后，直接丢一句保险素材给豆包，比如：

> "爱是从青丝到白发都能护你体面周全，这就是终身护理险"

豆包会先问你两三个问题挖你的真实想法和案例，然后输出 6 条朋友圈文案（3 条大咖原版 + 3 条合规版）。

## 文件结构

```
insurance-moments/
├── SKILL.md                          # 主技能文件
└── references/
    ├── voice-profiles.md             # 刘润/李笑来/黄执中口吻参考
    └── compliance-check.md           # 合规命题审查清单
```
