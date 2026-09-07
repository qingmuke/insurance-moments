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

打开 PowerShell，执行：

```powershell
irm https://raw.githubusercontent.com/qingmuke/insurance-moments/main/install.ps1 | iex
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
