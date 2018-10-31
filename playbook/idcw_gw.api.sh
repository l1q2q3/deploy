#!/bin/bash

install_path=/data/idcw/idcw_code
node_path=/data/idcw/versions/3.0.0
del_code(){

count='ls $install_path/$import2_set/$import3_job-$import2_set |wc -w'

if [[ $count > 0 ]] 
then
    echo "删除旧版本 $import3_job-$import2_set ..."
    cd $install_path/$import2_set/$import3_job-$import2_set && sudo rm -rf *  
fi

}

install_node(){

if [[ $import2_set == "test-233" ]]
then  
    echo "安装node..."
    cd $install_path/$import2_set/$import3_job-$import2_set
    yarn install 
    sleep 2
    sudo yarn run build:test
elif [[ $import2_set == "pre" ]]
then
    echo "安装node..."
    cd $install_path/$import2_set/$import3_job-$import2_set
    yarn install
    sleep 2
    sudo yarn run build    
fi

}

del_node_code(){
if [[ $import2_set == "test-233" ]]
then
    echo "删除节点旧版本 $import3_job-$import2_set ..."
    ssh jenkins@192.168.1.233 "cd $node_path/$import3_job && sudo rm -rf *"
elif [[ $import2_set == "pre" ]]
then
    echo "删除节点旧版本 $import3_job-$import2_set ..."
    ssh jenkins@118.193.190.120 "cd $node_path/$import3_job && sudo rm -rf *"
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
#安装node
install_node
#删除节点旧版本
del_node_code
#复制新版本到节点
echo "发布新版本 $import3_job-$import2_set ..."
ansible-playbook -s /etc/ansible/roles/idcw_gw.api.yml --extra-vars "job=$import3_job set=$import2_set host=$import1_host"
#删除旧版本
del_code
}

run $1 $2 $3
