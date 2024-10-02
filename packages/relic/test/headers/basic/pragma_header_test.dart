import 'dart:io';
import 'package:relic/src/headers.dart';
import 'package:relic/src/relic_server.dart';
import 'package:test/test.dart';
import '../../static/test_util.dart';

void main() {
  late RelicServer server;

  setUp(() async {
    try {
      server = await RelicServer.bind(InternetAddress.loopbackIPv6, 0);
    } on SocketException catch (_) {
      server = await RelicServer.bind(InternetAddress.loopbackIPv4, 0);
    }
  });

  tearDown(() => server.close());

  group('Pragma Header Tests', () {
    test('Given a valid Pragma header, it should parse correctly', () async {
      Headers headers = await getServerRequestHeaders(
        server: server,
        headers: {'pragma': 'no-cache'},
      );

      expect(headers.mPragma, equals('no-cache'));
    });

    test('Given no Pragma header, it should be null', () async {
      Headers headers = await getServerRequestHeaders(
        server: server,
        headers: {},
      );

      expect(headers.mPragma, isNull);
    });

    test('Given an empty Pragma header, it should return null', () async {
      Headers headers = await getServerRequestHeaders(
        server: server,
        headers: {'pragma': ''},
      );

      expect(headers.mPragma, isNull);
    });
  });
}
