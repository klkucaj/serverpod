import 'package:relic/src/headers.dart';
import 'package:test/test.dart';

import '../mocks/http_request_mock.dart';

void main() {
  group('ProxyAuthenticateHeader Class Tests', () {
    test('ProxyAuthenticateHeader should parse single authentication scheme',
        () {
      var headerValue = 'Basic';
      var proxyAuthenticateHeader =
          ProxyAuthenticateHeader.fromHeaderValue(headerValue);

      expect(proxyAuthenticateHeader.schemes.length, equals(1));
      expect(proxyAuthenticateHeader.schemes.contains('Basic'), isTrue);
    });

    test('ProxyAuthenticateHeader should parse multiple authentication schemes',
        () {
      var headerValue = 'Basic, Digest, Bearer';
      var proxyAuthenticateHeader =
          ProxyAuthenticateHeader.fromHeaderValue(headerValue);

      expect(proxyAuthenticateHeader.schemes.length, equals(3));
      expect(proxyAuthenticateHeader.schemes.contains('Basic'), isTrue);
      expect(proxyAuthenticateHeader.schemes.contains('Digest'), isTrue);
      expect(proxyAuthenticateHeader.schemes.contains('Bearer'), isTrue);
    });

    test('ProxyAuthenticateHeader should handle empty string as input', () {
      var proxyAuthenticateHeader = ProxyAuthenticateHeader.fromHeaderValue('');
      expect(proxyAuthenticateHeader.schemes, isEmpty);
    });

    test('ProxyAuthenticateHeader should return null when parsing a null value',
        () {
      var proxyAuthenticateHeader = ProxyAuthenticateHeader.tryParse(null);
      expect(proxyAuthenticateHeader, isNull);
    });

    test(
        'ProxyAuthenticateHeader should contain specific authentication scheme',
        () {
      var headerValue = 'Basic, Bearer';
      var proxyAuthenticateHeader =
          ProxyAuthenticateHeader.fromHeaderValue(headerValue);

      expect(proxyAuthenticateHeader.containsScheme('Bearer'), isTrue);
      expect(proxyAuthenticateHeader.containsScheme('Digest'), isFalse);
    });

    test(
        'ProxyAuthenticateHeader should return valid string representation of the header',
        () {
      var proxyAuthenticateHeader =
          ProxyAuthenticateHeader(schemes: ['Basic', 'Bearer']);
      var result = proxyAuthenticateHeader.toString();

      expect(result, equals('Basic, Bearer'));
    });
  });

  group('ProxyAuthenticateHeader HttpRequestMock Tests', () {
    test('Given a valid Proxy-Authenticate header, it should parse correctly',
        () {
      var httpRequest = HttpRequestMock()
        ..headers.add('Proxy-Authenticate', 'Basic, Digest');

      var headers = Headers.fromHttpRequest(httpRequest);
      var proxyAuthenticateHeader = headers.proxyAuthenticate;

      expect(proxyAuthenticateHeader!.schemes.length, equals(2));
      expect(proxyAuthenticateHeader.schemes.contains('Basic'), isTrue);
      expect(proxyAuthenticateHeader.schemes.contains('Digest'), isTrue);
    });

    test(
        'Given an empty Proxy-Authenticate header, it should return an empty list',
        () {
      var httpRequest = HttpRequestMock()
        ..headers.add('Proxy-Authenticate', '');

      var headers = Headers.fromHttpRequest(httpRequest);
      var proxyAuthenticateHeader = headers.proxyAuthenticate;

      expect(proxyAuthenticateHeader!.schemes, isEmpty);
    });
  });
}
