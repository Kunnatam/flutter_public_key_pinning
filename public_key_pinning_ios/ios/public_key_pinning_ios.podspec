Pod::Spec.new do |s|
  s.name             = 'public_key_pinning_ios'
  s.version          = '0.0.1'
  s.summary          = 'Flutter plugin for SSL pinning using public key.'
  s.description      = <<-DESC
An iOS flutter plugin for SSL pinning using public key.
                       DESC
  s.homepage         = 'https://github.com/Kunnatam/flutter_public_key_pinning'
  s.license          = { :file => '../LICENSE' }
  s.author           = { 'Your Company' => 'email@example.com' }
  s.source           = { :path => '.' }
  s.source_files = 'Classes/**/*'
  s.dependency 'Flutter'
  s.platform = :ios, '10.0'
  
  s.dependency 'Alamofire', '5.5.0'

  # Flutter.framework does not contain a i386 slice.
  s.pod_target_xcconfig = { 'DEFINES_MODULE' => 'YES', 'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'i386' }
  s.swift_version = '5.0'
end
