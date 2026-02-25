# ndlocr-lite-docker

国立国会図書館のOCRシステム [ndlocr-lite](https://github.com/ndl-lab/ndlocr-lite) をDockerコンテナで動作させるための環境です。

## 必要環境

- Docker / Docker Compose
- make

## 実行方法

### 1. ビルドと起動

初回のみビルドを行い、コンテナをバックグラウンドで起動します。

```bash
make build
make up
```

### 2. OCRの実行

`input/` ディレクトリに画像を配置し、ファイル名を指定して実行します。

```bash
make run FILE=test.png
```

### 3. 結果の確認

`output/<ファイル名（拡張子なし）>/` に結果が保存されます。

## 主要コマンド

| コマンド | 内容 |
| :--- | :--- |
| `make up` | コンテナの起動 |
| `make down` | コンテナの停止・削除 |
| `make run FILE=...` | OCR処理の実行 |
| `make clean` | `output/` 内の全結果を削除 |
| `make shell` | コンテナ内シェルへの接続 |
| `make logs` | ログの表示 |

## ディレクトリ構成

- `input/`: 入力画像配置用
- `output/`: OCR結果出力用（自動生成）
- `Dockerfile`: イメージ定義
- `docker-compose.yml`: 実行構成
- `Makefile`: 操作用コマンド

## ライセンス

- 本プロジェクト: [MIT License](LICENSE)
- ndlocr-lite: [CC-BY-4.0](https://github.com/ndl-lab/ndlocr-lite/blob/master/LICENCE) (国立国会図書館)