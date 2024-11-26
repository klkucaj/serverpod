import 'dart:io';
import 'package:test/test.dart';
import 'package:relic/src/headers/headers.dart';
import 'package:relic/src/relic_server.dart';

import '../headers_test_utils.dart';
import '../docs/strict_validation_docs.dart';

/// Reference: https://developer.mozilla.org/en-US/docs/Web/HTTP/Headers/Sec-Fetch-Dest
/// About empty value test, check the [StrictValidationDocs] class for more details.
void main() {
  group('Given a Sec-Fetch-Dest header with the strict flag true', () {
    late RelicServer server;

    setUp(() async {
      try {
        server = await RelicServer.createServer(
          InternetAddress.loopbackIPv6,
          0,
          strictHeaders: true,
        );
      } on SocketException catch (_) {
        server = await RelicServer.createServer(
          InternetAddress.loopbackIPv4,
          0,
          strictHeaders: true,
        );
      }
    });

    tearDown(() => server.close());

    test(
      'when an empty Sec-Fetch-Dest header is passed then the server should respond with a bad request '
      'including a message that states the value cannot be empty',
      () async {
        expect(
          () async => await getServerRequestHeaders(
            server: server,
            headers: {'sec-fetch-dest': ''},
          ),
          throwsA(isA<BadRequestException>().having(
            (e) => e.message,
            'message',
            contains('Value cannot be empty'),
          )),
        );
      },
    );

    test(
      'when a valid Sec-Fetch-Dest header is passed then it should parse the destination correctly',
      () async {
        Headers headers = await getServerRequestHeaders(
          server: server,
          headers: {'sec-fetch-dest': 'document'},
        );

        expect(headers.secFetchDest?.destination, equals('document'));
      },
    );

    test(
      'when a Sec-Fetch-Dest header with a custom destination is passed then it should parse correctly',
      () async {
        Headers headers = await getServerRequestHeaders(
          server: server,
          headers: {'sec-fetch-dest': 'custom-destination'},
        );

        expect(headers.secFetchDest?.destination, equals('custom-destination'));
      },
    );

    test(
      'when no Sec-Fetch-Dest header is passed then it should return null',
      () async {
        Headers headers = await getServerRequestHeaders(
          server: server,
          headers: {},
        );

        expect(headers.secFetchDest, isNull);
      },
    );
  });

  group('Given a Sec-Fetch-Dest header with the strict flag false', () {
    late RelicServer server;

    setUp(() async {
      try {
        server = await RelicServer.createServer(
          InternetAddress.loopbackIPv6,
          0,
          strictHeaders: false,
        );
      } on SocketException catch (_) {
        server = await RelicServer.createServer(
          InternetAddress.loopbackIPv4,
          0,
          strictHeaders: false,
        );
      }
    });

    tearDown(() => server.close());

    group('When an empty Sec-Fetch-Dest header is passed', () {
      test(
        'then it should return null',
        () async {
          Headers headers = await getServerRequestHeaders(
            server: server,
            headers: {},
          );

          expect(headers.secFetchDest, isNull);
        },
      );

      test(
        'then it should be recorded in the "failedHeadersToParse" field',
        () async {
          Headers headers = await getServerRequestHeaders(
            server: server,
            headers: {'sec-fetch-dest': ''},
          );

          expect(
            headers.failedHeadersToParse['sec-fetch-dest'],
            equals(['']),
          );
        },
      );
    });
  });
}