import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:perfect_volume_control/perfect_volume_control.dart';

void main() {
  const MethodChannel channel = MethodChannel('perfect_volume_control');

  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      return '42';
    });
  });

  tearDown(() {
    channel.setMockMethodCallHandler(null);
  });

  test('getPlatformVersion', () async {
    expect(await PerfectVolumeControl.platformVersion, '42');
  });
}
