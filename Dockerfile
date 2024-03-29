# 既存のプロジェクトのバージョンに合わせる
FROM ruby:3.2.0

# 起動させるためのパッケージを取得
RUN apt-get update \
    && apt-get install -y --no-install-recommends \
    # `build-essential`は開発に必須のビルドツールを提供しているパッケージ
    build-essential \
    mariadb-client \
    nodejs \
    vim \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*
# 作業用のディレクトリを作成(存在しない場合は勝手に作成してくれる)
WORKDIR /e_note

# ホストのGemfile達をコンテナ内にコピー
COPY Gemfile /e_note/Gemfile
COPY Gemfile.lock /e_note/Gemfile.lock

RUN gem install bundler
RUN bundle install
#既存railsプロジェクトをコンテナ内にコピー
COPY . /e_note

# entrypoint.shをコピーし、実行権限を与える
COPY entrypoint.sh /usr/bin/
# chmodコマンドはファイルやディレクトリに権限設定するコマンド。`+`は後に記述した権限を付加する。`x`は実行権限。
# つまり今回は全てのユーザに該当ファイルの実行権限を付与する。
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]
# `EXPOSE <ポート>`はコンテナ実行時に<ポート>にリッスンするよう命令するコマンド。
EXPOSE 3000

CMD ["rails", "server", "-b", "0.0.0.0"]
