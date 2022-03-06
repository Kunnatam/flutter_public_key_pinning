import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:public_key_pinning/public_key_pinning.dart';

void main() {
  const MethodChannel channel = MethodChannel('public_key_pinning');

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
    expect(await PublicKeyPinning.platformVersion, '42');
  });
}
