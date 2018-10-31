#!/bin/bash

install_path=/data/idcm/versions/4.0.0
idcm_yml_file=/data/idcm-deploy/playbook/upgrade.yml
rsync_cmd='rsync -vzrtopg --delete --progress  --exclude-from=/data/tools/exclude.txt'

#加载.net项目名称匹配脚本
. ../scrpit/match_netname.sh

Create_file(){

if [[ ! -d "$install_path/$pass2_set/$pass3_job-$pass2_set" ]]
then
    echo "创建文件夹 $pass3_job-$pass2_set "
    mkdir -p $install_path/$pass2_set/$pass3_job-$pass2_set
fi         
}

del_code(){

count='ls $install_path/$pass2_set/$pass3_job-$pass2_set |wc -w'

if [[ $count > 0 ]] 
then
    echo "删除旧版本 $pass3_job-$pass2_set ..."
    cd $install_path/$pass2_set/$pass3_job-$pass2_set && rm -rf *  
fi

}


run(){

#判断传入参数不能为空
if [[ $1 != "" ]] && [[ $2 != "" ]] && [[ $3 != "" ]]
then
    pass1_host=$1
    pass2_set=$2
    pass3_job=$3
    pass4=$4
else
    echo "没有传入参数！退出操作..."
    exit
fi

echo ""
#匹配名称
net_code_name
#创建文件夹
Create_file
#删除旧版本
del_code
#复制新版本
echo "代码库复制 $import_name ... "
$rsync_cmd $install_path/$pass2_set/netcore/NetCore/$import_name/ $install_path/$pass2_set/$pass3_job-$pass2_set/
sleep 3
#复制新版本到节点
echo "发布新版本 $pass3_job-$pass2_set ..."
ansible-playbook -s $idcm_yml_file --extra-vars "job=$pass3_job set=$pass2_set host=$pass1_host project=$pass4"
}

run $1 $2 $3 $4
