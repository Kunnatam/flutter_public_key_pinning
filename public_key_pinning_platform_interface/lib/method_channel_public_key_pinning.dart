import 'package:flutter/services.dart';
import 'package:public_key_pinning_platform_interface/evaluation.dart';
import 'package:public_key_pinning_platform_interface/public_key_pinning_platform_interface.dart';

class MethodChannelPublicKeyPinning extends PublicKeyPinningPlatform {
  static const _base = 'plugins/public_key_pinning';

  static const _mainChannel = MethodChannel(_base);

  @override
  Future<void> init(List<Evaluation> evaluations) {
    final evsList = evaluations.map((e) => e.toJson()).toList();
    final evs = {
      "evaluations": evsList,
    };
    return _mainChannel.invokeMethod('init', evs);
  }

  @override
  Future<bool> request({
    required String url,
    Map<String, String?>? headers,
  }) {
    final arguments = <String, dynamic>{
      'url': url,
      'headers': headers,
    };
    return _mainChannel.invokeMethod<bool>('request', arguments).then<bool>((bool? value) => value ?? false);
  }
}
