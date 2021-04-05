
import 'dart:async';

import 'package:flutter/services.dart';

class PerfectVolumeControl {
  static const MethodChannel _channel =
      const MethodChannel('perfect_volume_control');

  static Future<String> get platformVersion async {
    final String version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }
}
