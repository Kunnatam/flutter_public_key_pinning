import Flutter
import UIKit

public class SwiftPublicKeyPinningIOSPlugin: NSObject, FlutterPlugin {
  static let base = "plugins/public_key_pinning_ios"
  
  internal static var methodHandler = MethodHandler()
  
  public var methodChannel: FlutterMethodChannel?
  
  static var instance: SwiftPublicKeyPinningIOSPlugin?
  
  public static func register(with registrar: FlutterPluginRegistrar) {
    instance = SwiftPublicKeyPinningIOSPlugin()
    instance?.onRegister(registrar)
  }
  
  private func onRegister(_ registrar: FlutterPluginRegistrar) {
    methodChannel = FlutterMethodChannel(name: SwiftPublicKeyPinningIOSPlugin.base, binaryMessenger: registrar.messenger())
    methodChannel?.setMethodCallHandler(SwiftPublicKeyPinningIOSPlugin.methodHandler.handle)
  }
}
