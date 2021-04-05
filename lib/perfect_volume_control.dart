import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';

class PerfectVolumeControl {
  static const MethodChannel _channel =
      const MethodChannel('perfect_volume_control');

  /// 音量改变监听器流
  /// Volume change monitor flow
  static StreamController<double> _streamController =
      StreamController.broadcast();

  /// 音量改变监听器名称
  /// Volume change monitor name
  static const String _volumeChangeListenerName = "volumeChangeListener";

  /// 方法调用处理
  /// method invoke handler
  static Future<dynamic> _methodCallHandler(call) async {
    if (call.method == _volumeChangeListenerName) {
      double volume = call.arguments;
      _streamController.add(volume);
    }
  }

  /// 获得监听器流
  /// Get listener stream
  static Stream<double> get stream {
    _channel.setMethodCallHandler(_methodCallHandler);
    return _streamController.stream;
  }

  /// 根据[hide]隐藏或显示
  /// Hide or show according to [hide]
  static set hideUI(bool hide) {
    _channel.invokeMethod('hideUI', {"hide": hide});
  }

  /// 获得设备当前音量，此属性为 getVolume 的简单写法
  /// Get the current volume of the device，This property is a simple way to write getvolume
  static Future<double> get volume => getVolume();

  /// 获得设备当前音量
  /// Get the current volume of the device
  static Future<double> getVolume() async {
    return await _channel.invokeMethod('getVolume');
  }

  /// 根据[volume]设置设备音量，音量取值范围为 0.0 - 1.0
  /// Set the device volume according to [volume], and the volume range is 0.0 - 1.0
  static Future<void> setVolume(double volume) async {
    assert(volume >= 0 && volume <= 1);
    return await _channel.invokeMethod('setVolume', {"volume": volume});
  }
}
