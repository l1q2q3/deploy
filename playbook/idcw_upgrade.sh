#!/bin/bash

code_path=/data/idcw/idcw_code
code_src=/data/idcw/jobs
rsynccmd='rsync -vzrtopg --delete --progress  --exclude-from=/data/tools/exclude.txt'


Create_file(){
if [[ ! -d "$code_path/$import2_set/$import3_job" ]]
then
    echo "创建文件夹 $import3_job "
    mkdir -p $code_path/$import2_set/$import3_job
fi         
}

scp_code(){
if [[ $import2_set == "35" ]]
then
    $rsynccmd jenkins@192.168.1.35:$code_src/$import3_job/ $code_path/$import2_set/$import3_job/
elif [[ $import2_set == "88" ]]
then
    $rsynccmd jenkins@192.168.1.88:$code_src/$import3_job/ $code_path/$import2_set/$import3_job/
else
    echo "输入错误，没有匹配的环境"
fi
}


run(){
#判断传入参数不能为空
if [[ $1 != "" ]] && [[ $2 != "" ]] && [[ $3 != "" ]]
then
    import1_host=$1
    import2_set=$2
    import3_job=$3
else
    echo "没有传入参数！退出操作..."
    exit
fi

echo ""
#创建文件夹
Create_file
#复制新版本
scp_code
echo "测试服务器 $import2_set 拉取新版本"
sleep 3
#复制新版本到节点
echo "发布新版本 $import3_job-$import2_set ..."
ansible-playbook -s /etc/ansible/roles/idcw_upgrade.yml --extra-vars "job=$import3_job set=$import2_set host=$import1_host"
}

run $1 $2 $3
