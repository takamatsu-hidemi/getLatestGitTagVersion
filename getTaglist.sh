#!/bin/sh

# タグが作成されたらコメントアウト
# ローカル環境を最新化
# git fetch > /dev/null
# TAGS=`git tag -l`
# ARRAY_TAGS=(${TAGS// / })

# タグが作成されたらコメント
ARRAY_TAGS=("stock-front-v2.0.0" "release-assessment-front-v1.0.12"  "release-assessment-front-v0.129.10" "stock-front-v1.100.0" "stock-front-v1.0.2")

RELEASE_TAG_LIST=("release-assessment-front-v" "stock-front-v" "assessment-back-v" "stock-back-v" "assessment-batch-v" "stock-batch-v" "assessment-migration-v")

filteredTag () {
    FILTER_TAGS=()
    for TNAME in "${ARRAY_TAGS[@]}"
    do
        if $(echo $TNAME | grep $RNAME > /dev/null) ; then
            FILTER_TAGS=(${FILTER_TAGS[@]} ${TNAME})
        fi
    done
}

compare () {
    if [[ $1 == $2 ]]
    then
        return 0
    fi
    local IFS=.
    local i ver1=($1) ver2=($2)
    # ver1の空のフィールドをゼロで埋める
    for ((i=${#ver1[@]}; i<${#ver2[@]}; i++))
    do
        ver1[i]=0
    done
    for ((i=0; i<${#ver1[@]}; i++))
    do
        if [[ -z ${ver2[i]} ]]
        then
            # ver2の空のフィールドをゼロで埋める
            ver2[i]=0
        fi
        if ((10#${ver1[i]} > 10#${ver2[i]}))
        then
            return 1
        fi
        if ((10#${ver1[i]} < 10#${ver2[i]}))
        then
            return 2
        fi
    done
    return 0
}

getLatest () {
    LATEST_VERSION=0.0.0
    LATEST_TAG=""
    for TAG in "${FILTER_TAGS[@]}"
    do
        # バージョン(0.0.0)の形に変更
        TARGET_VERSION=`echo $TAG | tr -d $RNAME`
        compare $LATEST_VERSION $TARGET_VERSION
        RESULT=$?
        if [ $((RESULT)) -eq 2 ] ; then
            LATEST_VERSION=$TARGET_VERSION
            LATEST_TAG=$TAG
        fi
    done
    if [ -n "$LATEST_TAG" ]; then
        echo $LATEST_TAG
    fi

}

echo "〓 最新タグ 〓 〓 〓 〓 〓 〓"
for RNAME in "${RELEASE_TAG_LIST[@]}"
do
    filteredTag
    getLatest
done
echo "〓 〓 〓 〓 〓 〓 〓 〓 〓 〓"
