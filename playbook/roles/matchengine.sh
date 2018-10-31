#!/bin/bash

install_path=/data/idcm/versions/4.0.0

net_code_name(){
if [[ $import3_job == "matchengine" ]]
then
    import_name="IDCM.Host.MatchEngine"
else
    echo ""
    echo "JOB名称不匹配! 退出操作..."
    exit
fi
}

Create_file(){

if [[ ! -d "$install_path/$import2_set/$import3_job-$import2_set" ]]
then
    echo "创建文件夹"
    mkdir -p $install_path/$import2_set/$import3_job-$import2_set
fi         
}

del_code(){

count='ls $install_path/$import2_set/$import3_job-$import2_set |wc -w'

if [[ $count > 0 ]] 
then
    cd $install_path/$import2_set/$import3_job-$import2_set && rm -rf   
fi

}

updata_match(){
if [[ $import4_match == "all" ]]
then
    ansible-playbook -s /etc/ansible/roles/matchengine.yml --extra-vars "job=$import3_job set=$import2_set host=idcm-matchengine-pre updatamatch=$import4_match"
    sleep 3
    ansible-playbook -s /etc/ansible/roles/matchengine.yml --extra-vars "job=$import3_job set=$import2_set host=idcm-matchengine02-pre updatamatch=$import4_match"
else
    ansible-playbook -s /etc/ansible/roles/matchengine.yml --extra-vars "job=$import3_job set=$import2_set host=idcm-matchengine-pre updatamatch=$import4_match"
fi
}

run(){

#判断传入参数不能为空
if [[ $1 != "" ]] && [[ $2 != "" ]] && [[ $3 != "" ]] && [[ $4 != "" ]]
then
    import1_host=$1
    import2_set=$2
    import3_job=$3
    import4_match=$4
else
    echo ""
    echo "没有传入参数！退出操作..."
    exit
fi

#匹配名称
net_code_name
#创建文件夹
Create_file
#删除旧版本
del_code
#复制新版本
cp -rf $install_path/$import2_set/netcore/NetCore/$import_name/* $install_path/$import2_set/$import3_job-$import2_set/
#安装新版本
updata_match
}

run $1 $2 $3 $4
