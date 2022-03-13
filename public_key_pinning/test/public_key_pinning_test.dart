import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  const MethodChannel channel = MethodChannel('public_key_pinning');

  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {});

  tearDown(() {
    channel.setMockMethodCallHandler(null);
  });
}
