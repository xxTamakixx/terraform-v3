# ベースイメージの指定
FROM python:alpine

# 依存パッケージのインストール
RUN apk add gcc python3-dev libc-dev mariadb-dev && \
    pip3 install --upgrade pip

# ユーザーの追加方法
ARG USER_ID="1001"
ARG GROUP_ID="1002"
ARG USER_NAME="python"

RUN addgroup -S -g "${GROUP_ID}" "${USER_NAME}" && \
    adduser -u "${USER_ID}" -G "${USER_NAME}" -D "${USER_NAME}"

# 作業ディレクトリの設定
WORKDIR /app

# 必要なファイルをコンテナにコピー
COPY requirements.txt .

# 依存パッケージのインストール
RUN pip install --no-cache-dir -r requirements.txt

# アプリケーションのファイルをコンテナにコピー(パミッションの設定)
COPY --chown=1001:1002 . .

# ポートの公開（必要に応じて変更してください）
EXPOSE 8000

# /appのパミッション設定
# RUN chown -R 1001:1002 /app && \
#     chmod -R 744 /app

USER 1001

# コンテナ内で実行されるコマンドの指定
CMD ["python", "manage.py", "runserver", "0.0.0.0:8000"]