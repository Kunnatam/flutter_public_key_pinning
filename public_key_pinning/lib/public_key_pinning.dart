
import 'dart:async';

import 'package:flutter/services.dart';

class PublicKeyPinning {
  static const MethodChannel _channel = MethodChannel('public_key_pinning');

  static Future<String?> get platformVersion async {
    final String? version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }
}
