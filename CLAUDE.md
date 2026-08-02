# CLAUDE.md — COREON 官網建置專案（狀態文件）

> 這份檔案是這個專案的「活文件」——每次有重大進度或決議都要回來更新，
> 這樣不管誰（或哪個 AI session）接手，都能從這份檔案掌握完整現況，不用重新問一輪。

## 專案概況
- **品牌**：COREON — 產業特化型 ERP／數位轉型解決方案（母公司：威迪數位廣告科技）
- **正式網域**：https://coreon.tw （已綁定，www.coreon.tw 會 301 轉址到 coreon.tw）
- **部署**：Cloudflare Workers & Pages，專案名稱 `coreon-website`
- **原始碼**：GitHub `furukariswu-ui/coreon-website`（main branch）
- **本機專案位置**：`~/Desktop/專案資料/group-workspace/brands/coreon/COREON官網_cowork/coreon-site/`（2026-08-02 更正兩次：先從舊的 `~/Desktop/檔案整理/` 搬到 group-workspace，同一天稍晚品牌資料夾又從錯字 `cornon` 正名為 `coreon`，這行對應更新）

## 品牌資訊
- **一句話定位**：不只管客戶，更驅動核心業務——「產業營運大腦」
- **目標客群**：B2B，高成長企業；旗艦產業為金融融資公司，另涵蓋補習班、餐飲業、飲料店連鎖
- **服務地區**：全台
- **主要 SEO 關鍵字**：CRM ERP 系統、借貸管理系統、融資公司管理系統、企業數位轉型解決方案、AI 流程自動化
- **聯絡信箱**：coreon.tw@gmail.com
- **主要 CTA**：官方 LINE https://lin.ee/829kkoG（預約 Demo／諮詢）

## 視覺風格（v2，目前採用中）
第一版是線框藍圖風（四角切角、hairline 邊框），使用者參考另一張圖後，**改為圓潤現代 SaaS 風格**，第一版已棄用：
- 圓角卡片（radius 12–26px）、柔和陰影，而非直角+細邊框
- 區塊間用 `.fade-bottom` + `.fade-to-*` 做漸層過渡，取代生硬的色塊切割
  （⚠️ 這裡曾經出過 bug：舊版用負 margin 疊到上一個區塊，結果蓋住按鈕文字。
  現在的做法是漸層畫在自己區塊底部「內側」，z-index 壓在內容下方，不會再蓋到東西）
- 卡片／按鈕加 `.glow-hover` 做 hover 發光 + 上浮效果
- 進場淡入用 `.reveal` class + `js/main.js` 的 IntersectionObserver
- 品牌色票不變：暖橘 `--color-accent`(#e8912c) + 深藍綠 `--color-accent-2`(#1d4a52) + 米白 `--color-bg`(#faf4e8)
- 字體統一 **Noto Sans TC**（設計稿原字體 Barlow 系列是拉丁字體，不含中文字符，已棄用）
- 詳細 design token／component class 都在 `css/styles.css`，有寫註解

## 品牌素材（已取得，位於 `images/brand/`）
- `coreon-mark.webp` — 商標圖示（六角形 C+O），去背，導覽列早期版本／頁尾使用
- `coreon-horizontal.webp` — 圖示＋COREON＋標語橫式組合，**目前導覽列使用這個**
- `coreon-lockup.webp` — 圖示＋COREON＋標語直式堆疊
- `favicon.ico` / `favicon-32x32.png` / `favicon-16x16.png` / `apple-touch-icon.png` — 瀏覽器分頁圖示
- `mark_src.png`、`lockup_src.png` 是處理過程的中間檔，沒有被網頁引用，可以手動刪掉（環境權限問題我這邊刪不掉）

## 頁面進度
| 頁面 | 網址 | 狀態 |
|---|---|---|
| 首頁 | `/` | ✅ 完成 |
| 金融融資管理系統（旗艦方案） | `/solutions/finance-lending/` | ✅ 完成（文案來自使用者提供的 RTF） |
| 產業方案總覽 | `/industries/` | ✅ 完成（2026-08-02，含模組×產業對照表，補習班/餐飲飲料連鎖卡片先導向 LINE，無死連結） |
| 關於 COREON | `/about/` | ✅ 完成（2026-08-02，文案取自 `page_關於我們.rtf`，用 textutil 轉出正確文字後建置） |
| 常見問題 | `/faq` | ⬜ 待做 |
| 聯絡我們 | `/contact` | ⬜ 待做 |
| 隱私權政策 | `/privacy-policy` | ⬜ 待做 |
| 服務條款 | `/terms` | ⬜ 待做 |

> 2026-08-02 補充：nav 的「產業方案」已從 `#industries`/`/#industries` 錨點改成正式頁面 `/industries/`，並新增「關於COREON」nav項目指向 `/about/`（依本文件第52-55行的 SOP 執行）。首頁自己的 `#industries` 區塊內容保留，只是 nav 不再指過去。
> SEO/GEO 全站關鍵字與內容策略、執行進度見上一層 `../策略進度/`（`SEO_GEO策略與模組產業切入規劃.md` + `進度追蹤.md`）。發佈前先看 `進度追蹤.md` 確認本機/線上落差。

每做完一頁記得：
1. 更新這份文件的頁面進度表
2. 補上 `sitemap.xml` 的 `<url>` 項目
3. Nav 裡的連結如果原本是 anchor（例如 `/#industries`）要改成正式頁面網址

## SEO 規則（每頁必備）
- `<title>` 30 字內、`meta description` 80–110 字，兩者都要獨一無二
- Open Graph + Twitter Card
- JSON-LD（首頁用 Organization，方案頁用 Product + BreadcrumbList，未來 FAQ 頁用 FAQPage）
- 語意化 HTML、`sitemap.xml`、`robots.txt`
- 圖片一律 WebP，檔名語意化英文，alt 用中文；`images/` 依頁面 slug 分資料夾（`images/home/`、`images/solutions-finance-lending/` 等，已建好空資料夾）

## 部署與發佈流程（重要，之後每次更新都要照這個走）
1. 在 Cowork 這裡（`~/Desktop/檔案整理/COREON官網_cowork/coreon-site/`）編輯內容
2. 雙擊資料夾裡的 **「發佈上線.command」**
3. 這個腳本會自動：
   - 把檔案 rsync 複製到 `~/coreon-website-git`（**注意：不是這個資料夾本身在做 git**）
   - 在那邊做 `git add / commit / push` 到 GitHub `main` branch
   - Cloudflare 監聽到 GitHub push 後自動重新部署，1-2 分鐘內 coreon.tw 更新

### ⚠️ 為什麼要 rsync 到別的資料夾，不直接在這裡跑 git？
`~/Desktop/檔案整理/COREON官網_cowork/` 這個資料夾在 Desktop 底下，很可能被 iCloud Drive 同步。
Git 需要頻繁建立/刪除 lock 檔案，在 iCloud 同步資料夾裡常常卡住（"Another git process seems to be
running"、"unable to delete old refs" 這類錯誤），這是很多 Mac 開發者都踩過的坑。
**解法**：Git 的實際操作全部搬到 `~/coreon-website-git`（純本機、不同步），Cowork 這邊只負責編輯內容，
發佈腳本負責同步＋推送。**不要**在這個資料夾裡直接跑 `git init`（會重蹈覆轍）。

### ⚠️ GitHub 認證
GitHub 不接受帳號密碼做 git 操作，要用 Personal Access Token（Settings → Developer settings →
Personal access tokens → Generate new token (classic)，勾 `repo` 權限）。輸入一次後 macOS 鑰匙圈
（`credential.helper osxkeychain`）會記住，之後雙擊發佈就不會再問。

### 換電腦怎麼辦
- **網站程式碼**：已經在 GitHub（`furukariswu-ui/coreon-website`），這是最完整的備份，換電腦只要
  `git clone` 這個 repo 就能拿回所有網站檔案，不會遺失。「發佈上線.command」現在也會被推上 GitHub
  （不再排除在同步範圍外），所以 clone 下來就有腳本可以用。
- **Cloudflare 部署／網域 DNS**：完全在雲端（Cloudflare、GoDaddy 帳號），跟電腦無關，換電腦登入
  帳號就看得到，不用做任何搬移。
- **新電腦要做的事**：
  1. 把整個 `COREON官網_cowork` 資料夾（或至少 `coreon-site` + `網站建置流程SOP範本.md`）複製到新電腦
     （不一定要放 Desktop，建議放非 iCloud 同步的位置，例如 `~/Projects/`，直接避開 iCloud+git 的坑）
  2. 在新電腦的 Cowork 裡重新選取這個資料夾當連結資料夾
  3. 第一次雙擊「發佈上線.command」時，GitHub 會要求重新輸入 Personal Access Token
     （舊 token 如果還沒過期可以重複使用，貼上去就好；鑰匙圈記憶是綁在單一台電腦上的，不會跨機器帶過去）
- 簡單說：真正「怕丟」的東西都已經在 GitHub 上了，換電腦最多就是重新 clone + 重新登入一次 GitHub，不算麻煩。

### 網域小知識
- Cloudflare Registrar 不支援 `.tw` / `.com.tw`（查證於 2026-07，之後可能會變，要用時再查一次官方 TLD 清單）
- `coreon.tw` 是在 GoDaddy 買的，Nameserver 已指向 Cloudflare
- Cloudflare 專案目前顯示為 Workers（`npx wrangler deploy`），不是傳統 Pages 產品，網址型態是
  `coreon-website.furu-kariswu.workers.dev`（已停用/不對外use，正式網址一律用 coreon.tw）

## 待確認/待辦
- [ ] **⚠️ Cloudflare 部署異常**：2026-08-02 11:13 已 push 到 GitHub，超過30分鐘 coreon.tw 仍未更新（`/about/` 404、首頁 nav 仍舊版，`curl -I` 與瀏覽器都確認過）。GitHub 端確定有最新 commit，問題在 GitHub→Cloudflare 這段，需人工登入 Cloudflare Dashboard 查 `coreon-website` 專案的 Deployments 紀錄。細節見 `../策略進度/進度追蹤.md`。
- [ ] 剩餘 4 個頁面內容與建置（faq、contact、privacy-policy、terms）
- [ ] 表單目前無後端串接（`#contact` 的 email 表單只是靜態，尚未接 Cloudflare Pages Functions 或第三方表單服務）
- [ ] 全站 SEO 驗收清單 + 手機版本機預覽（尚未執行）
- [ ] 圖片素材陸續補：目前所有頁面示意圖都是 CSS/SVG 佔位圖，等有真實截圖/照片後要替換
