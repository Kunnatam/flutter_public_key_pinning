#import "PublicKeyPinningIOSPlugin.h"
#if __has_include(<public_key_pinning_ios/public_key_pinning_ios-Swift.h>)
#import <public_key_pinning_ios/public_key_pinning_ios-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "public_key_pinning_ios-Swift.h"
#endif

@implementation PublicKeyPinningIOSPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftPublicKeyPinningIOSPlugin registerWithRegistrar:registrar];
}
@end
