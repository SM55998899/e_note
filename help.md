eqは値が期待するものかどうかを判定するのに使う。これ使うことが圧倒的に多い。
beは大小比較でよく使う。（一応、インスタンスが同一かの比較にも使える）
raise_errorでエラーハンドリングの判定をする
expect{X}.to change{Y}.from(A).to(B)で、XするとYがAからBに変わることを期待する
配列+includeで配列に要素が含まれるかどうかの判定に使う。
be_within(Y).of(X)で「数値XがプラスマイナスYの範囲内に収まっていること」を判定する。

-------------------------

docker環境でのrspec起動
docker-compose exec web bundle exec guard

-------------------------

