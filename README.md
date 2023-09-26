# getLatestGitTagVersion

最新のリリースタグの一覧を取得するスクリプトです

# 事前準備

ローカルにリポジトリを clone した場所を各自の環境に合わせて修正してください

```
cd ../hoge
```

# 実行方法

引数を指定しない場合は assessment, stock 両方のタグの一覧が取得できます

```
sh getTaglist.sh
```

引数(assessment, stock)を指定した場合は assessment, stock 片方のタグの一覧が取得できます

```
sh getTaglist.sh assessment(stock)
```
