import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';

class PerfectVolumeControl {
  static const MethodChannel _channel = const MethodChannel('perfect_volume_control');

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
    assert(volume <= 0 && volume >= 1);
    return await _channel.invokeMethod('setVolume', {volume});
  }
}
