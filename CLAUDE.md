# CLAUDE.md — COREON 官網建置專案（狀態文件）

> 這份檔案是這個專案的「活文件」——每次有重大進度或決議都要回來更新，
> 這樣不管誰（或哪個 AI session）接手，都能從這份檔案掌握完整現況，不用重新問一輪。

> ⚠️ **2026-08-23 重大轉向＋架構重整**：COREON 從「金融融資/補習班/餐飲/飲料連鎖產業ERP」改為「Professional Service Operating System」（服務法律/財會稅務/顧問/建築設計/醫療健康管理）。同日站台架構也大改版，新的5個最上層頁籤：**認識Coreon**(`/understand/`)、**重塑營運**(`/transform/`)、**產業場景**(`/industries/`，內容已改寫成新5產業)、**案例洞察**(`/insights/`)、**關於我們**(`/about/`，URL不變但內容還沒更新)。這5個頁面（`index.html`／`understand/`／`transform/`／`insights/`／`industries/`）共用新的 `css/coreon-v2.css`（暖米`#F8F5EF`+橘`#F36B21`+Inter/Noto Sans TC），跟舊版`css/styles.css`是兩套系統。**`/about/`、`/solutions/finance-lending/`、`/blog/cram-school-line-notification/` 這三頁只更新了nav連結文字（指向新5頁籤），內容跟視覺都還是舊系統，尚未遷移。`/solutions/finance-lending/`（金融融資）、部落格的補習班文章，主題完全不在新的5產業分類裡，等於是孤兒頁面——nav已經不連到finance-lending了（產業不對應，拿掉了），部落格文章還留在`/insights/`裡但標註「較早期定位、跟現在主軸不完全一致」。這兩個孤兒頁面要保留/改寫/下架，需要使用者決定，不要自己處理。** 細節見 `../../EXECUTION_MEMO.md` 決策日誌。

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
> **2026-08-23 換新版 logo**：黑＋金分子節點風格圖示（圓弧C＋4顆金球節點連線）＋COREON字標（E中間橫槓金色），取代原本六角形C+O圖示。使用者提供單一橫式組合檔（`圖片/logo/coreon logo.png`，2172×724），我用Pillow去背＋裁切出圖示單獨版，全站共用檔名（`coreon-horizontal.webp`／`coreon-mark.webp`等）原地覆蓋，**沒有改動任何HTML**，新舊架構頁面、連同並行session負責的`/transform/`（用到`coreon-lockup.webp`當og:image）都自動吃到新版。
- `coreon-mark.webp` / `coreon-mark@2x.webp` — 商標圖示單獨版，去背，導覽列早期版本／頁尾使用
- `coreon-horizontal.webp` / `coreon-horizontal@2x.webp` — 圖示＋COREON橫式組合，**目前導覽列使用這個**
- `coreon-lockup.webp` — 圖示＋COREON置中組合（暖米底），給 og:image／social share 用（`/transform/`引用中）
- `favicon.ico`（16/32/48/64四合一）/ `favicon-32x32.png` / `favicon-16x16.png` / `apple-touch-icon.png` — 瀏覽器分頁圖示，都已換新版圖示
- `mark_src.png`、`lockup_src.png` 是**新版logo的高解析度去背母檔**（圖示單獨版/完整橫式版），之後要重新裁切/調整尺寸就從這兩個檔案出發，不要用原始的`圖片/logo/coreon logo.png`重跑（那份沒去背）

## 頁面進度
### 新架構（2026-08-23起，5大頁籤，用 css/coreon-v2.css）
| 頁面 | 網址 | 狀態 |
|---|---|---|
| 首頁 | `/` | ✅ 完成（Professional Service Operating System定位，已迭代3版） |
| 認識 Coreon | `/understand/` | ✅ 完成（9個子主題錨點卡片） |
| 重塑營運 | `/transform/` | ✅ 完成（**2026-08-23 晚間整頁重做**，11個Section：Hero舊流程→新流程、五大營運摩擦01-05、BPR提問區、COREON Method四階段、AS-IS/TO-BE拖曳比較、三層架構深色區、人／系統分工、標準化不僵化、營運可視化儀表板、Before/After價值對照、流程診斷CTA。**這頁不吃 `css/coreon-v2.css`，改用頁內 `<style>`+`<script>`**，跟新版首頁同樣做法） |
| 產業場景 | `/industries/` | ✅ 完成（**2026-08-23晚間再次整頁重做**成「短、視覺化、分流用」的Hub頁，不是內容頁：Hero用Core+3產業Layer視覺、Generic vs Coreon對照、8節點Operating Core架構圖、**3個滿寬Editorial Panel（法律/會計/顧問，左右交替排列，這是本頁核心轉換區）**、Industry≠Template說明、More Industries文字列表(Legal/Accounting/Consulting已上線，Architecture/Professional Services/Real Estate Services規劃中)、CTA。3個Panel的CTA暫連到LINE，因為`/industries/legal/`等產業detail page還沒建（brief本身也說「未來再慢慢增加」，這輪沒做）。用`css/coreon-v2.css`共用樣式。） |
| 案例洞察 | `/insights/` | ✅ 完成（FAQ已有6題真實內容+FAQPage schema；客戶案例/Before-After/產業洞察/流程指南誠實標「內容籌備中」，沒有編造假案例） |
| 關於我們 | `/about/` | ✅ 完成（2026-08-23重寫：10-section敘事版，60%故事/25%系統視覺/15%產品UI，含CORE+ON呼應、深色Vision區塊、6步驟BPR cascade） |

> **2026-08-23（晚）`/transform/` 改版重要教訓**：第一版試作把「五大營運摩擦 01-05」和「COREON Method 01-04」做成 sticky scroll（捲動時畫面固定、內容原地切換），使用者實測回饋**「滑動很卡、像當機」**，已全部拆掉——摩擦點改成一般文件流的大數字清單（01-05 逐列＋hairline 分隔線），Method 改成四列 row（左邊文字、右邊該階段狀態圖 SCATTERED→REORDERED→CONNECTED→IN FLOW）。**結論：這個站不要再用 sticky scroll／scroll-hijack 的區塊，捲動一律保持自然。**

### 舊架構殘留（nav已指向新5頁籤，但內容/視覺還是舊系統，未遷移）
| 頁面 | 網址 | 狀態 |
|---|---|---|
| 金融融資管理系統 | `/solutions/finance-lending/` | 🚩 孤兒頁面——主題不在新5產業分類裡，nav已移除連結，需使用者決定保留/改寫/下架 |
| 部落格：補習班LINE通知系統 | `/blog/cram-school-line-notification/` | 🚩 孤兒頁面——同上，暫掛在`/insights/`並標註「較早期定位」，需使用者決定 |
| 常見問題（舊版`/faq`規劃） | — | 已被新架構的 `/insights/#faq-list` 取代，不用再另外做 |
| 聯絡我們／隱私權政策／服務條款 | `/contact` `/privacy-policy` `/terms` | ⬜ 待做（新舊架構都還沒有） |

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
  - **2026-08-23 更新**：先前記錄過「本機 `sips` 無法輸出 WebP」的限制已解決——這台機器有裝 `python3` + Pillow（`pip` 套件，`python3 -c "from PIL import features; features.check('webp')"` 回傳 True），可以用 Pillow 直接做去背／裁切／resize／輸出 WebP／輸出多尺寸 ico，不用再手動用線上工具轉檔或退回存 PNG。之後有新圖片素材要處理，直接寫 Python/Pillow script 處理即可。
- **GA4 追蹤碼**（2026-08-02新增）：`<head>` 裡 viewport meta 後面要貼 gtag.js snippet，評估ID固定用 `G-TXDZ6K7RPB`，範本見 `index.html` 或任一既有頁面。新頁面上線前檢查有沒有漏貼。加強型評估（頁面瀏覽/捲動/外連點擊/表單互動等）已在GA4後台開啟，LINE點擊跟表單送出的轉換追蹤靠這個自動涵蓋，不用額外寫自訂事件。

## 部署與發佈流程（重要，之後每次更新都要照這個走）
1. 在 Cowork 這裡（`~/Desktop/專案資料/group-workspace/brands/coreon/COREON官網_cowork/coreon-site/`）編輯內容
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
- [x] ~~Cloudflare 部署異常~~ **已找到根因並修復（2026-08-02）**：Cloudflare Workers 專案 Settings→Build 顯示「disconnected from your Git account」；根因是 GitHub 上「Cloudflare Workers and Pages」這個 App 的 Repository access 設成「Only select repositories」，清單裡只有 `taiwanrentals-web`、`neibook-windy-finance` 兩個 repo，`coreon-website` 從一開始就沒被加進去（不是憑證過期）。使用者已在 GitHub App 設定裡把 `coreon-website` 加入 Repository access 並存檔，Cloudflare 端「disconnected」警告已消失。**待驗證**：加回權限後还没自動觸發新build，等下一次 push 確認是否真的恢復自動部署，見 `../策略進度/進度追蹤.md`。
- [ ] 剩餘 4 個頁面內容與建置（faq、contact、privacy-policy、terms）
- [ ] 表單目前無後端串接（`#contact` 的 email 表單只是靜態，尚未接 Cloudflare Pages Functions 或第三方表單服務）
- [ ] 全站 SEO 驗收清單 + 手機版本機預覽（尚未執行）
- [ ] 圖片素材陸續補：目前所有頁面示意圖都是 CSS/SVG 佔位圖，等有真實截圖/照片後要替換
