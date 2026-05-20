# 520 玫瑰互动网页

零依赖的浪漫 520 告白页：SVG 玫瑰花束 + 点击/长按触发告白卡片 + Canvas 玫瑰花瓣雨。

## 让别人搜到（上线 + SEO）

本地双击只能自己看；要**被百度/Google 搜到**，需要公网 HTTPS 地址并提交收录。

### 方式一：GitHub Pages（推荐，免费）

**前提**：安装 [Git](https://git-scm.com/) 和 [GitHub CLI](https://cli.github.com/)，并执行 `gh auth login`。

在项目目录 PowerShell 中运行：

```powershell
cd 520-love
.\scripts\deploy-github.ps1
```

然后在 GitHub 仓库网页：**Settings → Pages → Build and deployment → Source 选 `GitHub Actions`**。  
约 1–3 分钟后 Actions 完成，访问：

`https://<你的GitHub用户名>.github.io/520-love/`

把站点地址写入 sitemap（替换占位符）：

```powershell
.\scripts\set-site-url.ps1 -BaseUrl "https://<你的用户名>.github.io/520-love"
git add robots.txt sitemap.xml
git commit -m "chore: update sitemap URL"
git push
```

### 方式二：Netlify / Vercel

把整个 `520-love` 文件夹拖到 [Netlify Drop](https://app.netlify.com/drop) 或导入 Vercel，会得到 `https://xxx.netlify.app` 一类地址，同样可分享、可提交搜索引擎。

### 提交搜索引擎（收录）

| 平台 | 操作 |
|------|------|
| **Google** | [Google Search Console](https://search.google.com/search-console) 添加资源 → 验证所有权 → 「站点地图」提交 `sitemap.xml` 完整 URL |
| **百度** | [百度搜索资源平台](https://ziyuan.baidu.com/) 添加站点 → 验证 → 提交 `sitemap.xml` 或手动提交首页 URL |

说明：新站收录通常需要 **几天到几周**，且竞争词「520」较难排靠前；标题与描述已做 SEO，分享链接时也会显示摘要。

### 已内置的 SEO

- `meta description` / `keywords` / `robots`
- Open Graph / Twitter 卡片（分享微信、微博等更易显示标题）
- `canonical` 与 JSON-LD 结构化数据
- [`robots.txt`](robots.txt)、[`sitemap.xml`](sitemap.xml)

---

## 打开方式（本地）

1. **最简单**：双击 [`index.html`](index.html)，用浏览器打开即可。
2. **本地服务器**（可选）：在项目目录运行 `npx serve .` 或 VS Code Live Server，访问 `http://localhost:...`。

## 交互说明

| 操作 | 效果 |
|------|------|
| 单击花束 | 展开告白卡片 + 玫瑰花瓣雨（约 10 秒） |
| 长按花束（≥0.6 秒） | 同上，并附加玫瑰「绽放」光晕动画 |
| 点击遮罩或 × | 关闭卡片，停止花瓣雨 |
| 右上角 ♪ | 开关背景音乐（需先添加音频文件） |

## 自定义告白文案

编辑 [`index.html`](index.html) 中 `.card-body` 里的 `<p>` 段落，以及 `.card-title`、`.card-footer` 文字即可。

```html
<h2 class="card-title" id="card-title">520 · 我爱你</h2>
<div class="card-body">
  <p>你的第一句告白</p>
  <p>你的第二句告白</p>
  <p>你的第三句告白</p>
</div>
<p class="card-footer">— 送给特别的你 —</p>
```

## 添加背景音乐

1. 新建目录 `assets/`
2. 放入 `bg.mp3`（建议轻柔纯音乐，循环播放）
3. 刷新页面，点击花束或右上角 ♪ 即可播放

若未放置音频文件，页面仍可正常使用，音乐按钮不会报错。

## 无障碍

系统开启「减少动态效果」时，会自动关闭花瓣雨与呼吸动画，仅保留静态玫瑰与告白卡片。

## 文件结构

```
520-love/
  index.html      # 完整页面（HTML + CSS + JS）
  README.md       # 本说明
  assets/
    bg.mp3        # 可选背景音乐
```
