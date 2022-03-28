import 'dart:async';

import 'package:flutter/services.dart';
import 'package:public_key_pinning_platform_interface/evaluation.dart';

class PublicKeyPinningAndroid {
  static const MethodChannel _channel = MethodChannel('plugins/public_key_pinning_android');

  Future<void> init(List<Evaluation> evaluations) async {
    //! Bypass pin check untill native Android version is implemented.
    return;

    // final evs = {
    //   "evaluations": evaluations,
    // };
    // return methodChannel.invokeMethod('init', evs);
  }

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
