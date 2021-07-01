#!/bin/sh
# author: xxyangyoulin
# url: https://github.com/xxyangyoulin/polybar_easy_script

LOG=$EASY_SH_PATH/log/juhe-weather.log;
CACHE=$EASY_SH_PATH/cache/juhe-weather.cache;

read last_time info wid temp < $CACHE;

echoinfo(){
    echo "$1 $2°C"
}

echostale(){
    now_time=$(date +%s)
    if [ -n "$last_time" ] && [ $(($now_time-$last_time)) -lt 10800 ];then
        echoinfo $info $temp
    else
        echoinfo "~"$info $temp
    fi
}

if [ -n "$last_time" -a ! "$info" = "null" ];then
    now_time=$(date +%s)
    if [ $(($now_time-$last_time)) -lt 900  ];then
        echoinfo $info $temp
        return;
    fi
fi

API="http://apis.juhe.cn/simpleWeather/query"
KEY=""
CITY="清镇"

weather=$(curl -sf "$API?key=$KEY&city=$CITY")

if [ -n "$weather" ]; then
    weather_info=$(echo "$weather" | jq -r ".result.realtime.info")
    weather_wid=$(echo "$weather" | jq -r ".result.realtime.wid")
    weather_temp=$(echo "$weather" | jq -r ".result.realtime.temperature")

    if [ "$weather_info" = "null" ];then
        # 获取天气失败，使用旧的数据,超过3小时未更新，则加上～前缀
        echostale;
    else
        echoinfo $weather_info $weather_temp
        
        echo $(date +%s) $weather_info $weather_wid $weather_temp > $CACHE
    fi

    echo "$(date)" "更新; 城市：$CITY 天气：$weather" > $LOG
else
    echostale;
fi
