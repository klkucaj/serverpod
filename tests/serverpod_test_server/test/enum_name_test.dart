import 'package:serverpod_test_server/src/generated/protocol.dart';
import 'package:test/test.dart';

void main() {
  test(
      'Given an enum with one of its values named "name" '
      'when calling "toString()" on the value "type" '
      'then it should return the Dart code name "type" and not the "name" field',
      () {
    expect(TestNameEnum.type.toString(), 'type');
  });

  test(
      'Given an enum with one of its values named "name" '
      'when calling "toString()" on the value "name" '
      'then it should return the Dart code name "name" and not any custom field',
      () {
    expect(TestNameEnum.name.toString(), 'name');
  });
}
