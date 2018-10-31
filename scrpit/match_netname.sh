#!/bin/bash

net_code_name(){
if [[ $pass3_job == adminsite ]]
then
    import_name="IDCM.AdminSite"
elif [[ $pass3_job == c2capi ]]
then
    import_name="IDCM.WebApiC2C"
elif [[ $pass3_job == c2cscheduler ]]
then
    import_name="IDCM.Host.C2CScheduler"
elif [[ $pass3_job == "internal.api" ]]
then
    import_name="IDCM.InternalSystemApi"
elif [[ $pass3_job == "internal.scheduler" ]]
then
    import_name="IDCM.Host.InternalSystemScheduler"
elif [[ $pass3_job == "matchengine" ]]
then
    import_name="IDCM.Host.MatchEngine"
elif [[ $pass3_job == persistence ]]
then
    import_name="IDCM.Persistence.SyncData"
elif [[ $pass3_job == "promotion.server" ]]
then
    import_name="IDCM.PromotionServer"
elif [[ $pass3_job == "quotes" ]]
then
    import_name="IDCM.Host.QuoteStatistic"
elif [[ $pass3_job == "scheduler" ]]
then
    import_name="IDCM.Host.Scheduler"
elif [[ $pass3_job == "websocket.api" ]]
then
    import_name="IDCM.Host.WebSocketAPI"
elif [[ $pass3_job == "webapi" ]]
then
    import_name="IDCM.WebApiNotServer"
elif [[ $pass3_job == "webapimining" ]]
then
    import_name="IDCM.WebApiMining"
elif [[ $pass3_job == "hostmining" ]]
then
    import_name="IDCM.Host.Mining"
elif [[ $pass3_job == "webapi.promotion" ]]
then
    import_name="IDCM.WebApiPromotion"
elif [[ $pass3_job == "websocket.ssl" ]]
then
    import_name="IDCM.Host.WebSocketAPI"
elif [[ $pass3_job == "webapi.alliance" ]]
then
    import_name="IDCM.WebApiAlliance"
elif [[ $pass3_job == "kline.persistence" ]]
then
    import_name="IDCM.Host.KLinePersistence"
elif [[ $pass3_job == "webapi.maintain" ]]
then
    import_name="IDCM.WebAPIMaintain"
elif [[ $pass3_job == "webapi.external" ]]
then
    import_name="IDCM.WebApiExternal"
elif [[ $pass3_job == "webapi.pokerblock" ]]
then
    import_name="IDCM.WebApiPokerBlock"
elif [[ $pass3_job == "flexpusher" ]]
then
    import_name="IDCM.Host.FlexPusher"
else
    echo "JOB名称不匹配! 退出操作..."
    exit
fi
}
