<div align="center">

[![](https://img.shields.io/pub/v/perfect_volume_control.svg)](https://pub.dartlang.org/packages/perfect_volume_control)
[![](https://img.shields.io/github/license/JiangJuHong/FlutterPerfectVolumeControl)](https://www.apache.org/licenses/LICENSE-2.0)
[![](https://img.shields.io/badge/qq群-850923396-1)](https://jq.qq.com/?_wv=1027&k=QxCWMlUf)

</div>

[\[中文文档\]](https://github.com/JiangJuHong/FlutterPerfectVolumeControl/blob/master/README-zh.md)
[\[English Docs\]](https://github.com/JiangJuHong/FlutterPerfectVolumeControl/blob/master/README.md)

# What is FlutterPerfectVolumeControl ?

Flutter volume control plug-in, supports Android and IOS, has: Show
hidden volume icon, volume change monitoring, set volume, get the
current volume of the device.

<img src="https://github.com/JiangJuHong/access-images/blob/master/FlutterPerfectVolumeControl/1.png" height="300em" style="max-width:100%;display: inline-block;"/>

# Link

* [Document](https://pub.dev/documentation/perfect_volume_control/latest/perfect_volume_control/PerfectVolumeControl-class.html)
* [Chat](https://jq.qq.com/?_wv=1027&k=QxCWMlUf)
* [Sponsor](https://www.yuque.com/jiangjuhong/tencent-im-flutter/ygi582)

# Use

## Get device volume

```dart
PerfectVolumeControl.getVolume();
PerfectVolumeControl.volume;
````

## Set device volume

````dart
PerfectVolumeControl.setVolume(0.3);
````

## Hide volume UI

````dart
PerfectVolumeControl.hideUI = true;
PerfectVolumeControl.hideUI = false;
````

## Volume change subscription

````dart
PerfectVolumeControl.stream.listen((volume) {
  print(volume);
});
````

# Other Plugins

````
I also maintain the following plug-ins. If you are interested in maintaining with me, please contact me through GitHub. Welcome issues and PR.
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

