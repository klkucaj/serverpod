import 'dart:io';
import 'package:test/test.dart';
import 'package:relic/src/headers/headers.dart';
import 'package:relic/src/relic_server.dart';

import '../headers_test_utils.dart';

/// Reference: https://developer.mozilla.org/en-US/docs/Web/HTTP/Headers/Set-Cookie
void main() {
  group('Given a Set-Cookie header with the strict flag true', () {
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
      'when an empty Set-Cookie header is passed then the server responds '
      'with a bad request including a message that states the header value cannot be empty',
      () async {
        expect(
          () async => await getServerRequestHeaders(
            server: server,
            headers: {'set-cookie': ''},
          ),
          throwsA(
            isA<BadRequestException>().having(
              (e) => e.message,
              'message',
              contains('Value cannot be empty'),
            ),
          ),
        );
      },
    );

    test(
      'when a Set-Cookie header with invalid format is passed then the server responds '
      'with a bad request including a message that states the cookie format is invalid',
      () async {
        expect(
          () async => await getServerRequestHeaders(
            server: server,
            headers: {'set-cookie': 'sessionId=abc123; invalidCookie'},
          ),
          throwsA(
            isA<BadRequestException>().having(
              (e) => e.message,
              'message',
              contains('Invalid cookie format'),
            ),
          ),
        );
      },
    );

    test(
      'when a valid Set-Cookie header is passed then it should parse the cookies correctly',
      () async {
        Headers headers = await getServerRequestHeaders(
          server: server,
          headers: {'set-cookie': 'sessionId=abc123; userId=42'},
        );

        expect(
          headers.setCookie?.cookies.map((c) => c.name).toList(),
          equals(['sessionId', 'userId']),
        );
        expect(
          headers.setCookie?.cookies.map((c) => c.value).toList(),
          equals(['abc123', '42']),
        );
      },
    );

    test(
      'when a valid Set-Cookie header with duplicate cookies is passed then it should '
      'parse the cookies correctly and remove the duplicates',
      () async {
        Headers headers = await getServerRequestHeaders(
          server: server,
          headers: {
            'set-cookie': 'sessionId=abc123; userId=42; sessionId=abc123'
          },
        );

        expect(
          headers.setCookie?.cookies.map((c) => c.name).toList(),
          equals(['sessionId', 'userId']),
        );
        expect(
          headers.setCookie?.cookies.map((c) => c.value).toList(),
          equals(['abc123', '42']),
        );
      },
    );

    test(
      'when a Set-Cookie header is passed with extra whitespace then it should parse the cookies correctly',
      () async {
        Headers headers = await getServerRequestHeaders(
          server: server,
          headers: {'set-cookie': ' sessionId=abc123 ; userId=42 '},
        );

        expect(
          headers.setCookie?.cookies.map((c) => c.name).toList(),
          equals(['sessionId', 'userId']),
        );
        expect(
          headers.setCookie?.cookies.map((c) => c.value).toList(),
          equals(['abc123', '42']),
        );
      },
    );
  });

  group('Given a Set-Cookie header with the strict flag false', () {
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

    group('when parsing an invalid cookie header', () {
      test(
        'when an invalid Set-Cookie header is passed then it should return null',
        () async {
          Headers headers = await getServerRequestHeaders(
            server: server,
            headers: {'set-cookie': 'sessionId=abc123; invalidCookie'},
          );

          expect(headers.setCookie, isNull);
        },
      );

      test(
        'when an invalid Set-Cookie header is passed then it should be recorded in failedHeadersToParse',
        () async {
          Headers headers = await getServerRequestHeaders(
            server: server,
            headers: {'set-cookie': 'sessionId=abc123; invalidCookie'},
          );

          expect(
            headers.failedHeadersToParse['set-cookie'],
            equals(['sessionId=abc123; invalidCookie']),
          );
        },
      );
    });
  });
}