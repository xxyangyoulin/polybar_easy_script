# polybar_easy_script

polybar状态栏的个人小工具、脚本集合！

### 使用提醒

使用本脚本需在polybar启动前加入`$EASY_SH_PATH`变量，**指定脚本所在位置**。

并且在该位置下建立三个目录：`cache`、`log`、`polybar_easy_script`三个文件夹。`polybar_easy_script`文件夹即为本项目的`clone`。

> 或者手动修改脚本中的文件路径。

---

### 聚合天气（juhe.cn）

openweathermap虽然免费并且差不多可以无限调用，但是在中国境内的精度堪忧。我发现国内聚合数据（juhe.cn）也提供得有免费方案，不过不是无限制的，每天免费100次。

本脚本已加入调用限制，避免`polybar`的重启或者`interval =`的设置过短导致调用过度！放心使用。

**1. 到juhe.cn注册并在`juhe-weather.sh`中添加KEY和支持的城市名**

```js
KEY=""
CITY="清镇"
```

**2. polybar配置**

```sh
[module/juhe-weather]
type = custom/script
exec = $EASY_SH_PATH/polybar_easy_script/juhe-weather.sh
interval = 15
label-font = 3
```

