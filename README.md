e_noteは単語を効率的に学習するための勉強ツールです。

開発言語: Ruby3.2.0

使用フレームワーク: Ruby on Rails7

使用した技術: 
            テスト: Rspec
            
			インフラ: CircleCI
                     AWS(EC2, RDS, VPC)

ローカルでの起動方法: ターミナル上に[bundle exec rails s -b 0.0.0.0]と入力して実行(Docker導入後だと起動できない可能性がある)

Dockerを使った起動方法: ターミナル上で[docker start 'app、dbそれぞれのコンテナ番号']を入力して実行