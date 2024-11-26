import 'dart:io';
import 'package:test/test.dart';
import 'package:relic/src/headers/headers.dart';
import 'package:relic/src/relic_server.dart';

import '../headers_test_utils.dart';
import '../docs/strict_validation_docs.dart';

/// Reference: https://developer.mozilla.org/en-US/docs/Web/HTTP/Headers/Cross-Origin-Resource-Policy
/// About empty value test, check the [StrictValidationDocs] class for more details.
void main() {
  group('Given a Cross-Origin-Resource-Policy header with the strict flag true',
      () {
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
      'when an empty Cross-Origin-Resource-Policy header is passed then the server should respond with a bad request '
      'including a message that states the value cannot be empty',
      () async {
        expect(
          () async => await getServerRequestHeaders(
            server: server,
            headers: {'cross-origin-resource-policy': ''},
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
      'when a valid Cross-Origin-Resource-Policy header is passed then it should parse the policy correctly',
      () async {
        Headers headers = await getServerRequestHeaders(
          server: server,
          headers: {'cross-origin-resource-policy': 'same-origin'},
        );

        expect(
          headers.crossOriginResourcePolicy?.policy,
          equals('same-origin'),
        );
      },
    );

    test(
      'when a Cross-Origin-Resource-Policy header with a custom policy is passed then it should parse correctly',
      () async {
        Headers headers = await getServerRequestHeaders(
          server: server,
          headers: {'cross-origin-resource-policy': 'custom-policy'},
        );

        expect(
          headers.crossOriginResourcePolicy?.policy,
          equals('custom-policy'),
        );
      },
    );

    test(
      'when no Cross-Origin-Resource-Policy header is passed then it should return null',
      () async {
        Headers headers = await getServerRequestHeaders(
          server: server,
          headers: {},
        );

        expect(headers.crossOriginResourcePolicy, isNull);
      },
    );
  });

  group(
      'Given a Cross-Origin-Resource-Policy header with the strict flag false',
      () {
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

    group('When an empty Cross-Origin-Resource-Policy header is passed', () {
      test(
        'then it should return null',
        () async {
          Headers headers = await getServerRequestHeaders(
            server: server,
            headers: {},
          );
          expect(headers.crossOriginResourcePolicy, isNull);
        },
      );

      test(
        'then it should be recorded in the "failedHeadersToParse" field',
        () async {
          Headers headers = await getServerRequestHeaders(
            server: server,
            headers: {'cross-origin-resource-policy': ''},
          );

          expect(
            headers.failedHeadersToParse['cross-origin-resource-policy'],
            equals(['']),
          );
        },
      );
    });
  });
}