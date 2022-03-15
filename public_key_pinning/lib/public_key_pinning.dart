import 'dart:async';

import 'package:public_key_pinning/evaluation.dart';
import 'package:public_key_pinning_platform_interface/public_key_pinning_platform_interface.dart';

Future<void> init(List<Evaluation> evaluations) {
  return PublicKeyPinningPlatform.instance.init(evaluations);
}

Future<bool> request({
  required String url,
  Map<String, String>? headers,
}) {
  return PublicKeyPinningPlatform.instance.request(url: url, headers: headers);
}
