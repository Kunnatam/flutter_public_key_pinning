import 'package:flutter/services.dart';
import 'package:public_key_pinning_platform_interface/public_key_pinning_platform_interface.dart';

class MethodChannelPublicKeyPinning extends PublicKeyPinningPlatform {
  static const _base = 'com.klaa.plugins/public_key_pinning';

  static const _mainChannel = MethodChannel(_base);

  @override
  Future<void> init(List<Evaluation> evaluations) {
    return _mainChannel.invokeMethod(
      'init',
      <String, dynamic>{
        'evaluations': evaluations,
      },
    );
  }

  @override
  Future<bool> request({
    required String url,
    Map<String, String?>? headers,
  }) {
    return _mainChannel.invokeMethod<bool>(
      'request',
      <String, dynamic>{
        'url': url,
        'headers': headers,
      },
    ).then<bool>((bool? value) => value ?? false);
  }
}
