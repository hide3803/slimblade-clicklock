# SlimBlade ClickLock (Ubuntu)
ClickLock for Kensington SlimBlade Pro Trackball on Ubuntu  
USB / 2.4GHz ドングルで動作確認済み  
Bluetooth は現在未対応（今後対応予定）

---

## 🎯 このツールは何？
Kensington SlimBlade Pro で Windows にある **ClickLock（クリック長押し → ドラッグ継続）** を  
**Ubuntu で再現するためのスクリプト** です。

Ubuntu には標準機能が無いため、自動でクリック保持を検知し  
ドラッグを継続する処理を追加しています。

---

## 🛠 作者  
**hide と HAL (ChatGPT)** による共同制作です。  
Ubuntu でも快適なトラックボール操作をしたい、という思いから作成しました。

---

## 📥 インストール方法

### 1. リポジトリをダウンロード
```bash
git clone https://github.com/hide3803/slimblade-clicklock.git
cd slimblade-clicklock
