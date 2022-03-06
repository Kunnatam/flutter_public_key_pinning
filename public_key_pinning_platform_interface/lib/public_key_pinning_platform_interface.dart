import 'dart:async';

import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'method_channel_public_key_pinning.dart';

/// The interface that implementations of public_key_pinning must implement.
///
/// Platform implementations should extend this class rather than implement it as `public_key_pinning`
/// does not consider newly added methods to be breaking changes. Extending this class
/// (using `extends`) ensures that the subclass will get the default implementation, while
/// platform implementations that `implements` this interface will be broken by newly added
/// [PublicKeyPinningPlatform] methods.
abstract class PublicKeyPinningPlatform extends PlatformInterface {
  /// Constructs a PublicKeyPinningPlatform.
  PublicKeyPinningPlatform() : super(token: _token);

  static final Object _token = Object();

  static PublicKeyPinningPlatform _instance = MethodChannelPublicKeyPinning();

  /// The default instance of [PublicKeyPinningPlatform] to use.
  ///
  /// Defaults to [MethodChannelPublicKeyPinning].
  static PublicKeyPinningPlatform get instance => _instance;

  /// Platform-specific plugins should set this with their own platform-specific
  /// class that extends [PublicKeyPinningPlatform] when they register themselves.
  static set instance(PublicKeyPinningPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  /// Initialize public key pinning session on native platform by the given list of [Evaluation].
  Future<void> init(List<Evaluation> evaluations) {
    throw UnimplementedError('init() has not been implemented.');
  }

  /// Make a request using the given [url] with [headers]. Returns [true] if the pinning process
  Future<bool> request({
    required String url,
    Map<String, String?>? headers,
  }) {
    throw UnimplementedError('request() has not been implemented.');
  }
}

/// An evaluation pairing [fileName].der to the evaluating host server with the given [hostName].
class Evaluation {
  final String hostName;

  final String fileName;

  const Evaluation({
    required this.hostName,
    required this.fileName,
  });

  factory Evaluation.fromJson(Map<String, dynamic> json) => Evaluation(
        hostName: json["hostName"],
        fileName: json["fileName"],
      );

  Map<String, dynamic> toJson() => {
        "hostName": hostName,
        "fileName": fileName,
      };
}
