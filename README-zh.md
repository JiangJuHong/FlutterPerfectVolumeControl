<div align="center">

[![](https://img.shields.io/pub/v/perfect_volume_control.svg)](https://pub.dartlang.org/packages/perfect_volume_control)
[![](https://img.shields.io/github/license/JiangJuHong/FlutterPerfectVolumeControl)](https://www.apache.org/licenses/LICENSE-2.0)
[![](https://img.shields.io/badge/qq群-850923396-1)](https://jq.qq.com/?_wv=1027&k=QxCWMlUf)

</div>

# 什么是 FlutterPerfectVolumeControl ?

Flutter
音量控制插件，支持Android和IOS，拥有：显示隐藏音量图标，音量变化监控，设置音量，获取设备当前音量。

# 链接

* [Document](https://pub.dev/documentation/perfect_volume_control/latest/perfect_volume_control/PerfectVolumeControl-class.html)
* [Chat](https://jq.qq.com/?_wv=1027&k=QxCWMlUf)
* [Sponsor](https://www.yuque.com/jiangjuhong/tencent-im-flutter/ygi582)

# 使用

## 获得音量

```dart
PerfectVolumeControl.getVolume();
PerfectVolumeControl.volume;
````

## 设置音量
````dart
PerfectVolumeControl.setVolume(0.3);
````

## 隐藏/显示 UI
````dart
PerfectVolumeControl.hideUI = true;
PerfectVolumeControl.hideUI = false;
````

## 音量变化监听
````dart
PerfectVolumeControl.stream.listen((volume) {
  print(volume);
});
````

# 其它插件

````
我同时维护的还有以下插件，如果您感兴趣与我一起进行维护，请通过Github联系我，欢迎 issues 和 PR。
````

| 平台     | 插件                                                                                      | 描述                      | 版本                                                                                                                                 |
|:--------|:------------------------------------------------------------------------------------------|:-------------------------|:------------------------------------------------------------------------------------------------------------------------------------|
| Flutter | [FlutterPerfectVolumeControl](https://github.com/JiangJuHong/FlutterPerfectVolumeControl) | Flutter 完美的音量控制器插件 | [![pub package](https://img.shields.io/pub/v/perfect_volume_control.svg)](https://pub.dartlang.org/packages/perfect_volume_control) |
| Flutter | [FlutterTencentImPlugin](https://github.com/JiangJuHong/FlutterTencentImPlugin)           | 腾讯云IM插件               | [![pub package](https://img.shields.io/pub/v/tencent_im_plugin.svg)](https://pub.dartlang.org/packages/tencent_im_plugin)           |
| Flutter | [FlutterTencentRtcPlugin](https://github.com/JiangJuHong/FlutterTencentRtcPlugin)         | 腾讯云Rtc插件              | [![pub package](https://img.shields.io/pub/v/tencent_rtc_plugin.svg)](https://pub.dartlang.org/packages/tencent_rtc_plugin)         |
| Flutter | [FlutterXiaoMiPushPlugin](https://github.com/JiangJuHong/FlutterXiaoMiPushPlugin)         | 小米推送SDK插件            | [![pub package](https://img.shields.io/pub/v/xiao_mi_push_plugin.svg)](https://pub.dartlang.org/packages/xiao_mi_push_plugin)       |
| Flutter | [FlutterHuaWeiPushPlugin](https://github.com/JiangJuHong/FlutterHuaWeiPushPlugin)         | 华为推送(HMS Push)插件     | [![pub package](https://img.shields.io/pub/v/hua_wei_push_plugin.svg)](https://pub.dartlang.org/packages/hua_wei_push_plugin)       |
| Flutter | [FlutterTextSpanField](https://github.com/JiangJuHong/FlutterTextSpanField)               | 自定义文本样式输入框         | [![pub package](https://img.shields.io/pub/v/text_span_field.svg)](https://pub.dartlang.org/packages/text_span_field)               |
| Flutter | [FlutterClipboardListener](https://github.com/JiangJuHong/FlutterClipboardListener)       | 粘贴板监听器               | [![pub package](https://img.shields.io/pub/v/clipboard_listener.svg)](https://pub.dartlang.org/packages/clipboard_listener)         |
| Flutter | [FlutterQiniucloudLivePlugin](https://github.com/JiangJuHong/FlutterQiniucloudLivePlugin) | Flutter 七牛云直播云插件    | 暂未发布，通过 git 集成                                                                                                                 |

