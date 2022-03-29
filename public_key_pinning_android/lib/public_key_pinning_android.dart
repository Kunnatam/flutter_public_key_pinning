import 'dart:async';

import 'package:flutter/services.dart';
import 'package:public_key_pinning_platform_interface/evaluation.dart';
import 'package:public_key_pinning_platform_interface/public_key_pinning_platform_interface.dart';

class PublicKeyPinningAndroid extends PublicKeyPinningPlatform {
  static const MethodChannel _channel = MethodChannel('plugins/public_key_pinning_android');

  static void registerWith() {
    PublicKeyPinningPlatform.instance = PublicKeyPinningAndroid();
  }

  @override
  Future<void> init(List<Evaluation> evaluations) async {
    //! Bypass pin check untill native Android version is implemented.
    return;

    // final evs = {
    //   "evaluations": evaluations,
    // };
    // return methodChannel.invokeMethod('init', evs);
  }

  @override
  Future<bool> request({
    required String url,
    Map<String, dynamic>? headers,
  }) async {
    //! Bypass pin check untill native Android version is implemented.
    return true;

    // final arguments = {
    //   'url': url,
    //   'headers': headers,
    // };
    // return methodChannel.invokeMethod<bool>('request', arguments).then<bool>((bool? value) => value ?? false);
  }
}
