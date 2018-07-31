#!/bin/bash

cd $(dirname $0)

echo -e "\033[32m -------------------需要执行pod install还是pod update(i/u)?------------------- \033[0m"

read ioru

if [ $ioru == 'i' ]; then
    pod install;
else
    echo -e "\033[32m ---------------------是否需要更新本地仓库(y/n)?--------------------- \033[0m"

    read choice

    if [ $choice == 'y' ]; then
        pod update;
    else
        pod update --verbose --no-repo-update;
    fi
fi


