import Flutter
import UIKit

public class SwiftPublicKeyPinningPlugin: NSObject, FlutterPlugin {
  static let base = "plugins/public_key_pinning_ios"
  
  internal static var methodHandler = MethodHandler()
  
  public var methodChannel: FlutterMethodChannel?
  
  static var instance: SwiftPublicKeyPinningPlugin?
  
  public static func register(with registrar: FlutterPluginRegistrar) {
    instance = SwiftPublicKeyPinningPlugin()
    instance?.onRegister(registrar)
  }
  
  private func onRegister(_ registrar: FlutterPluginRegistrar) {
    methodChannel = FlutterMethodChannel(name: SwiftPublicKeyPinningPlugin.base, binaryMessenger: registrar.messenger())
    methodChannel?.setMethodCallHandler(SwiftPublicKeyPinningPlugin.methodHandler.handle)
  }

}
