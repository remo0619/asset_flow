# AssetFlow 企業向け資産管理アプリ
![ロゴ](app/assets/images/logo.png)
![トップページ](app/assets/images/ScreenShot01.png)
![マイページ](app/assets/images/ScreenShot02.png)

## アプリの概要
社内備品の管理・貸出フローをデジタル化し、効率的な資産管理を支援するシステムです。  
PCや外付けHDDなどの備品在庫を可視化し、従業員による利用申請から管理者による承認までをワンストップで完結させます。

## 開発背景
現職の備品貸出フローにおいて、在庫確認や申請をチャットで行うことによる情報の不透明さを解消したいと考え、本アプリを開発しました。  
機器のステータスを可視化し、申請・承認フローを一つのシステムに統合することで、誰でも「今何が借りられるか」を即座に判断し、スムーズに手続きを進められるシステムを目標に開発しました。

## 主要機能
・一般権限、管理者権限共通  
┗ 備品一覧: 登録されている備品のステータス（利用可能・貸出中）を確認。
┗ 利用申請機能: 利用期間を入力し、承認者を選択して申請。  
┗ マイページ： 利用中の機器参照、申請履歴参照。

・管理者権限のみ  
┗ 機器登録: 新たに機器を登録する機能。  
┗ 承認・否認ワークフロー: 申請に対してコメント付きの承認/否認アクション。  
┗ マイページ：登録した機器参照、未承認申請参照、承認・否認済み申請参照。

## 使用技術
### フロントエンド
・HTML / CSS / JavaScript  
・BootStrap 5: レイアウト

### バックエンド
・Ruby 3.3.3  
・Ruby on Rails 7.2.3   
・Devise: ユーザー認証機能

### データベース
・PostgreSQL（本番環境）  
・SQLite3（開発環境）

### テスト・品質管理
・RSpec: Model/System Spec  
・GitHub Actions

### インフラ・開発環境
・Vercel: デプロイ  
・Git/GitHub: ソースコード・バージョン管理

## DB設計
```mermaid
erDiagram
    USER ||--o{ DEVICE : registers
    USER ||--o{ REQUEST : "submits (applicant)"
    USER ||--o{ REQUEST : "approves (approve)"
    DEVICE ||--o{ REQUEST : targets

    USER {
        integer id PK
        string name
        string email
        string password
        integer authority "enum: 0:user, 1:admin"
    }

    DEVICE {
        integer id PK
        integer user_id FK
        string serial
        string device_type
        integer status "enum: 0:available, 1:borrowed, 2:unavailable"
    }

    REQUEST{
        integer id PK
        integer user_id FK
        integer approver_id FK
        integer device_id FK
        date start_date
        date end_date
        text comment
        integer status "enum: 0:pending, 1:approved, 2:rejected, 3:returned"
    }
```

## 今後の展望

### 短期的な目標
・備品検索機能の追加  
・マイページの一覧にページネーション導入  
・データの整合性を考慮した、備品やアカウントの削除機能  

### 中長期的な目標
・通知機能の拡充  
ユーザー体験向上のため、アプリ内通知に加え、LINE Messaging APIやSlack Webhookを利用した外部ツールへの通知連携を実装し、承認漏れや確認遅延を防ぐ仕組みを構築予定です。

・動的な承認ワークフローへの対応  
現在の1対1の承認フローから、組織構造に合わせた多段承認（例：申請者 → 上長 → 部長）や、承認ルートの動的な変更に対応可能にします。

・承認プロセスの可視化  
ステータス管理をより詳細化し、現在誰が確認中なのか、どこでプロセスが止まっているのかを視覚的に把握できるようにします。