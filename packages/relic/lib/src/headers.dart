import 'dart:collection';
import 'dart:convert';
import 'dart:io' as io;
import 'dart:math';

import 'package:http_parser/http_parser.dart';

import 'body.dart';

part 'headers/custom_headers.dart';
part 'headers/authorization_header.dart';

abstract class Headers {
  static const _acceptHeader = "accept";
  static const _acceptCharsetHeader = "accept-charset";
  static const _acceptEncodingHeader = "accept-encoding";
  static const _acceptLanguageHeader = "accept-language";
  static const _acceptRangesHeader = "accept-ranges";
  static const _accessControlAllowCredentialsHeader =
      'access-control-allow-credentials';
  static const _accessControlAllowOriginHeader = 'access-control-allow-origin';
  static const _accessControlExposeHeadersHeader =
      'access-control-expose-headers';
  static const _accessControlMaxAgeHeader = 'access-control-max-age';
  static const _accessControlRequestHeadersHeader =
      'access-control-request-headers';
  static const _accessControlRequestMethodHeader =
      'access-control-request-method';
  static const _ageHeader = "age";
  static const _allowHeader = "allow";

  static const _authorizationHeader = "authorization";

  static const _cacheControlHeader = "cache-control";
  static const _connectionHeader = "connection";
  static const _contentEncodingHeader = "content-encoding";
  static const _contentLanguageHeader = "content-language";
  static const _contentLengthHeader = "content-length";
  static const _contentLocationHeader = "content-location";
  static const _contentMD5Header = "content-md5";
  static const _contentRangeHeader = "content-range";
  static const _contentTypeHeader = "content-type";
  static const _dateHeader = "date";
  static const _etagHeader = "etag";
  static const _expectHeader = "expect";
  static const _expiresHeader = "expires";
  static const _fromHeader = "from";
  static const _hostHeader = "host";
  static const _ifMatchHeader = "if-match";
  static const _ifModifiedSinceHeader = "if-modified-since";
  static const _ifNoneMatchHeader = "if-none-match";
  static const _ifRangeHeader = "if-range";
  static const _ifUnmodifiedSinceHeader = "if-unmodified-since";
  static const _lastModifiedHeader = "last-modified";
  static const _locationHeader = "location";
  static const _maxForwardsHeader = "max-forwards";
  static const _pragmaHeader = "pragma";
  static const _proxyAuthenticateHeader = "proxy-authenticate";
  static const _proxyAuthorizationHeader = "proxy-authorization";
  static const _rangeHeader = "range";
  static const _refererHeader = "referer";
  static const _retryAfterHeader = "retry-after";
  static const _serverHeader = "server";
  static const _teHeader = "te";
  static const _trailerHeader = "trailer";
  static const _transferEncodingHeader = "transfer-encoding";
  static const _upgradeHeader = "upgrade";
  static const _userAgentHeader = "user-agent";
  static const _varyHeader = "vary";
  static const _viaHeader = "via";
  static const _warningHeader = "warning";
  static const _wwwAuthenticateHeader = "www-authenticate";
  static const _contentDispositionHeader = "content-disposition";
  static const _xPoweredByHeader = 'X-Powered-By';

  static const _defaultXPoweredByHeader = 'Serverpod Relic';

  // Define header properties
  final DateTime? date;
  final DateTime? expires;
  final DateTime? ifModifiedSince;
  final String? from;
  final String? host;
  final int? port;
  final Uri? location;
  final String? xPoweredBy;
  final List<String>? accept;
  final List<String>? acceptCharset;
  final List<String>? acceptEncoding;
  final List<String>? acceptLanguage;
  final List<String>? acceptRanges;
  final String? accessControlAllowCredentials;
  final String? accessControlAllowOrigin;
  final List<String>? accessControlExposeHeaders;
  final String? accessControlMaxAge;
  final List<String>? accessControlRequestHeaders;
  final String? accessControlRequestMethod;
  final String? age;
  final List<String>? allow;
  final AuthorizationHeader? authorization;
  final List<String>? cacheControl;
  final List<String>? connection;
  final List<String>? contentEncoding;
  final List<String>? contentLanguage;
  final String? contentLength;
  final String? contentLocation;
  final String? contentMD5;
  final String? contentRange;
  final String? contentType;
  final String? etag;
  final String? expect;
  final List<String>? ifMatch;
  final List<String>? ifNoneMatch;
  final String? ifRange;
  final String? ifUnmodifiedSince;
  final String? lastModified;
  final String? maxForwards;

  /// Renamed from `[pragma]` to `mPragma` to avoid conflict with Dart's `[pragma]` type.
  final String? mPragma;
  final List<String>? proxyAuthenticate;
  final String? proxyAuthorization;
  final String? range;
  final String? referer;
  final String? retryAfter;
  final String? server;
  final List<String>? te;
  final List<String>? trailer;
  final List<String>? transferEncoding;
  final List<String>? upgrade;
  final String? userAgent;
  final List<String>? vary;
  final List<String>? via;
  final List<String>? warning;
  final List<String>? wwwAuthenticate;
  final String? contentDisposition;

  final CustomHeaders custom;

  static const _managedHeaders = <String>{
    _dateHeader,
    _expiresHeader,
    _ifModifiedSinceHeader,
    _hostHeader,
    _contentTypeHeader,
    _locationHeader,
    _xPoweredByHeader,
    _acceptHeader,
    _authorizationHeader,
    _acceptCharsetHeader,
    _acceptEncodingHeader,
    _acceptLanguageHeader,
    _acceptRangesHeader,
    _accessControlAllowCredentialsHeader,
    _accessControlAllowOriginHeader,
    _accessControlExposeHeadersHeader,
    _accessControlMaxAgeHeader,
    _accessControlRequestHeadersHeader,
    _accessControlRequestMethodHeader,
    _ageHeader,
    _allowHeader,
    _cacheControlHeader,
    _connectionHeader,
    _contentEncodingHeader,
    _contentLanguageHeader,
    _contentLengthHeader,
    _contentLocationHeader,
    _contentMD5Header,
    _contentRangeHeader,
    _etagHeader,
    _expectHeader,
    _ifMatchHeader,
    _ifNoneMatchHeader,
    _ifRangeHeader,
    _ifUnmodifiedSinceHeader,
    _lastModifiedHeader,
    _maxForwardsHeader,
    _pragmaHeader,
    _proxyAuthenticateHeader,
    _proxyAuthorizationHeader,
    _rangeHeader,
    _refererHeader,
    _retryAfterHeader,
    _serverHeader,
    _teHeader,
    _trailerHeader,
    _transferEncodingHeader,
    _upgradeHeader,
    _userAgentHeader,
    _varyHeader,
    _viaHeader,
    _warningHeader,
    _wwwAuthenticateHeader,
    _contentDispositionHeader,
  };

  Headers._({
    this.date,
    this.expires,
    this.ifModifiedSince,
    this.from,
    this.host,
    this.port,
    this.location,
    this.xPoweredBy,
    this.accept,
    this.acceptCharset,
    this.acceptEncoding,
    this.acceptLanguage,
    this.acceptRanges,
    this.accessControlAllowCredentials,
    this.accessControlAllowOrigin,
    this.accessControlExposeHeaders,
    this.accessControlMaxAge,
    this.accessControlRequestHeaders,
    this.accessControlRequestMethod,
    this.age,
    this.allow,
    this.contentDisposition,
    this.authorization,
    this.cacheControl,
    this.connection,
    this.contentEncoding,
    this.contentLanguage,
    this.contentLength,
    this.contentLocation,
    this.contentMD5,
    this.contentRange,
    this.contentType,
    this.etag,
    this.expect,
    this.ifMatch,
    this.ifNoneMatch,
    this.ifRange,
    this.ifUnmodifiedSince,
    this.lastModified,
    this.maxForwards,
    this.mPragma,
    this.proxyAuthenticate,
    this.proxyAuthorization,
    this.range,
    this.referer,
    this.retryAfter,
    this.server,
    this.te,
    this.trailer,
    this.transferEncoding,
    this.upgrade,
    this.userAgent,
    this.vary,
    this.via,
    this.warning,
    this.wwwAuthenticate,
    CustomHeaders? custom,
  }) : custom = custom ?? CustomHeaders.empty();

  factory Headers.fromHttpRequest(io.HttpRequest request) {
    var headers = request.headers;

    return _HeadersImpl(
      date: headers.date,
      expires: headers.expires,
      ifModifiedSince: headers.ifModifiedSince,
      from: headers.value(_fromHeader),
      host: headers.host,
      port: headers.port,
      accept: headers[_acceptHeader],
      acceptCharset: headers[_acceptCharsetHeader],
      acceptEncoding: headers[_acceptEncodingHeader],
      acceptLanguage: headers[_acceptLanguageHeader],
      acceptRanges: headers[_acceptRangesHeader],
      accessControlAllowCredentials:
          headers.value(_accessControlAllowCredentialsHeader),
      accessControlAllowOrigin: headers.value(_accessControlAllowOriginHeader),
      accessControlExposeHeaders: headers[_accessControlExposeHeadersHeader],
      accessControlMaxAge: headers.value(_accessControlMaxAgeHeader),
      accessControlRequestHeaders: headers[_accessControlRequestHeadersHeader],
      accessControlRequestMethod:
          headers.value(_accessControlRequestMethodHeader),
      age: headers.value(_ageHeader),
      allow: headers[_allowHeader],
      contentDisposition: headers.value(_contentDispositionHeader),
      contentType: headers.value(_contentTypeHeader),
      cacheControl: headers[_cacheControlHeader],
      connection: headers[_connectionHeader],
      contentEncoding: headers[_contentEncodingHeader],
      contentLanguage: headers[_contentLanguageHeader],
      contentLength: headers.value(_contentLengthHeader),
      contentLocation: headers.value(_contentLocationHeader),
      contentMD5: headers.value(_contentMD5Header),
      contentRange: headers.value(_contentRangeHeader),
      etag: headers.value(_etagHeader),
      expect: headers.value(_expectHeader),
      ifMatch: headers[_ifMatchHeader],
      ifNoneMatch: headers[_ifNoneMatchHeader],
      ifRange: headers.value(_ifRangeHeader),
      ifUnmodifiedSince: headers.value(_ifUnmodifiedSinceHeader),
      lastModified: headers.value(_lastModifiedHeader),
      maxForwards: headers.value(_maxForwardsHeader),
      mPragma: headers.value(_pragmaHeader),
      proxyAuthenticate: headers[_proxyAuthenticateHeader],
      proxyAuthorization: headers.value(_proxyAuthorizationHeader),
      range: headers.value(_rangeHeader),
      referer: headers.value(_refererHeader),
      retryAfter: headers.value(_retryAfterHeader),
      server: headers.value(_serverHeader),
      te: headers[_teHeader],
      trailer: headers[_trailerHeader],
      transferEncoding: headers[_transferEncodingHeader],
      upgrade: headers[_upgradeHeader],
      userAgent: headers.value(_userAgentHeader),
      vary: headers[_varyHeader],
      via: headers[_viaHeader],
      warning: headers[_warningHeader],
      wwwAuthenticate: headers[_wwwAuthenticateHeader],
      custom: CustomHeaders._fromHttpHeaders(
        headers,
        excludedHeaders: _managedHeaders,
      ),
      authorization: AuthorizationHeader._tryParseHttpHeaders(
        headers,
      ),
    );
  }

  factory Headers.request({
    DateTime? date,
    DateTime? expires,
    DateTime? ifModifiedSince,
    String? from,
    String? host,
    int? port,
    Uri? location,
    String? xPoweredBy,
    List<String>? accept,
    List<String>? acceptCharset,
    List<String>? acceptEncoding,
    List<String>? acceptLanguage,
    List<String>? acceptRanges,
    String? accessControlAllowCredentials,
    String? accessControlAllowOrigin,
    List<String>? accessControlExposeHeaders,
    String? accessControlMaxAge,
    List<String>? accessControlRequestHeaders,
    String? accessControlRequestMethod,
    String? age,
    List<String>? allow,
    String? contentDisposition,
    AuthorizationHeader? authorization,
    List<String>? cacheControl,
    List<String>? connection,
    List<String>? contentEncoding,
    List<String>? contentLanguage,
    String? contentLength,
    String? contentLocation,
    String? contentMD5,
    String? contentRange,
    String? contentType,
    String? etag,
    String? expect,
    List<String>? ifMatch,
    List<String>? ifNoneMatch,
    String? ifRange,
    String? ifUnmodifiedSince,
    String? lastModified,
    String? maxForwards,
    String? mPragma,
    List<String>? proxyAuthenticate,
    String? proxyAuthorization,
    String? range,
    String? referer,
    String? retryAfter,
    String? server,
    List<String>? te,
    List<String>? trailer,
    List<String>? transferEncoding,
    List<String>? upgrade,
    String? userAgent,
    List<String>? vary,
    List<String>? via,
    List<String>? warning,
    List<String>? wwwAuthenticate,
    CustomHeaders? custom,
  }) {
    return _HeadersImpl(
      date: date ?? DateTime.now(),
      expires: expires,
      ifModifiedSince: ifModifiedSince,
      from: from,
      host: host,
      port: port,
      location: location,
      xPoweredBy: xPoweredBy,
      accept: accept,
      acceptCharset: acceptCharset,
      acceptEncoding: acceptEncoding,
      acceptLanguage: acceptLanguage,
      acceptRanges: acceptRanges,
      accessControlAllowCredentials: accessControlAllowCredentials,
      accessControlAllowOrigin: accessControlAllowOrigin,
      accessControlExposeHeaders: accessControlExposeHeaders,
      accessControlMaxAge: accessControlMaxAge,
      accessControlRequestHeaders: accessControlRequestHeaders,
      accessControlRequestMethod: accessControlRequestMethod,
      age: age,
      allow: allow,
      contentDisposition: contentDisposition,
      authorization: authorization,
      cacheControl: cacheControl,
      connection: connection,
      contentEncoding: contentEncoding,
      contentLanguage: contentLanguage,
      contentLength: contentLength,
      contentLocation: contentLocation,
      contentMD5: contentMD5,
      contentRange: contentRange,
      contentType: contentType,
      etag: etag,
      expect: expect,
      ifMatch: ifMatch,
      ifNoneMatch: ifNoneMatch,
      ifRange: ifRange,
      ifUnmodifiedSince: ifUnmodifiedSince,
      lastModified: lastModified,
      maxForwards: maxForwards,
      mPragma: mPragma,
      proxyAuthenticate: proxyAuthenticate,
      proxyAuthorization: proxyAuthorization,
      range: range,
      referer: referer,
      retryAfter: retryAfter,
      server: server,
      te: te,
      trailer: trailer,
      transferEncoding: transferEncoding,
      upgrade: upgrade,
      userAgent: userAgent,
      vary: vary,
      via: via,
      warning: warning,
      wwwAuthenticate: wwwAuthenticate,
      custom: custom ?? CustomHeaders.empty(),
    );
  }

  factory Headers.response({
    DateTime? date,
    DateTime? expires,
    DateTime? ifModifiedSince,
    String? from,
    String? host,
    int? port,
    Uri? location,
    String? xPoweredBy,
    List<String>? accept,
    List<String>? acceptCharset,
    List<String>? acceptEncoding,
    List<String>? acceptLanguage,
    List<String>? acceptRanges,
    String? accessControlAllowCredentials,
    String? accessControlAllowOrigin,
    List<String>? accessControlExposeHeaders,
    String? accessControlMaxAge,
    List<String>? accessControlRequestHeaders,
    String? accessControlRequestMethod,
    String? age,
    List<String>? allow,
    String? contentDisposition,
    AuthorizationHeader? authorization,
    List<String>? cacheControl,
    List<String>? connection,
    List<String>? contentEncoding,
    List<String>? contentLanguage,
    String? contentLength,
    String? contentLocation,
    String? contentMD5,
    String? contentRange,
    String? contentType,
    String? etag,
    String? expect,
    List<String>? ifMatch,
    List<String>? ifNoneMatch,
    String? ifRange,
    String? ifUnmodifiedSince,
    String? lastModified,
    String? maxForwards,
    String? mPragma,
    List<String>? proxyAuthenticate,
    String? proxyAuthorization,
    String? range,
    String? referer,
    String? retryAfter,
    String? server,
    List<String>? te,
    List<String>? trailer,
    List<String>? transferEncoding,
    List<String>? upgrade,
    String? userAgent,
    List<String>? vary,
    List<String>? via,
    List<String>? warning,
    List<String>? wwwAuthenticate,
    CustomHeaders? custom,
  }) {
    return _HeadersImpl(
      date: date ?? DateTime.now(),
      expires: expires,
      ifModifiedSince: ifModifiedSince,
      from: from,
      host: host,
      port: port,
      location: location,
      xPoweredBy: xPoweredBy,
      accept: accept,
      acceptCharset: acceptCharset,
      acceptEncoding: acceptEncoding,
      acceptLanguage: acceptLanguage,
      acceptRanges: acceptRanges,
      accessControlAllowCredentials: accessControlAllowCredentials,
      accessControlAllowOrigin: accessControlAllowOrigin,
      accessControlExposeHeaders: accessControlExposeHeaders,
      accessControlMaxAge: accessControlMaxAge,
      accessControlRequestHeaders: accessControlRequestHeaders,
      accessControlRequestMethod: accessControlRequestMethod,
      age: age,
      allow: allow,
      contentDisposition: contentDisposition,
      authorization: authorization,
      cacheControl: cacheControl,
      connection: connection,
      contentEncoding: contentEncoding,
      contentLanguage: contentLanguage,
      contentLength: contentLength,
      contentLocation: contentLocation,
      contentMD5: contentMD5,
      contentRange: contentRange,
      contentType: contentType,
      etag: etag,
      expect: expect,
      ifMatch: ifMatch,
      ifNoneMatch: ifNoneMatch,
      ifRange: ifRange,
      ifUnmodifiedSince: ifUnmodifiedSince,
      lastModified: lastModified,
      maxForwards: maxForwards,
      mPragma: mPragma,
      proxyAuthenticate: proxyAuthenticate,
      proxyAuthorization: proxyAuthorization,
      range: range,
      referer: referer,
      retryAfter: retryAfter,
      server: server,
      te: te,
      trailer: trailer,
      transferEncoding: transferEncoding,
      upgrade: upgrade,
      userAgent: userAgent,
      vary: vary,
      via: via,
      warning: warning,
      wwwAuthenticate: wwwAuthenticate,
      custom: custom ?? CustomHeaders.empty(),
    );
  }

  void applyHeaders(io.HttpResponse response, Body body) {
    var headers = response.headers;
    headers.clear();

    headers.date = date?.toUtc() ?? DateTime.now().toUtc();
    headers.expires = expires;
    headers.ifModifiedSince = ifModifiedSince;
    headers.host = host;
    headers.port = port;
    if (from != null) headers.set(_fromHeader, from!);

    headers.set(_xPoweredByHeader, xPoweredBy ?? _defaultXPoweredByHeader);

    // Set the content type from the Body
    headers.contentType = io.ContentType(
      body.contentType.mimeType.primaryType,
      body.contentType.mimeType.subType,
      charset: body.contentType.encoding?.name,
    );
  }

  Headers copyWith({
    DateTime? date,
    DateTime? expires,
    DateTime? ifModifiedSince,
    String? from,
    String? host,
    int? port,
    Uri? location,
    String? xPoweredBy,
    List<String>? accept,
    List<String>? acceptCharset,
    List<String>? acceptEncoding,
    List<String>? acceptLanguage,
    List<String>? acceptRanges,
    String? accessControlAllowCredentials,
    String? accessControlAllowOrigin,
    List<String>? accessControlExposeHeaders,
    String? accessControlMaxAge,
    List<String>? accessControlRequestHeaders,
    String? accessControlRequestMethod,
    String? age,
    List<String>? allow,
    String? contentDisposition,
    AuthorizationHeader? authorization,
    List<String>? cacheControl,
    List<String>? connection,
    List<String>? contentEncoding,
    List<String>? contentLanguage,
    String? contentLength,
    String? contentLocation,
    String? contentMD5,
    String? contentRange,
    String? contentType,
    String? etag,
    String? expect,
    List<String>? ifMatch,
    List<String>? ifNoneMatch,
    String? ifRange,
    String? ifUnmodifiedSince,
    String? lastModified,
    String? maxForwards,
    String? mPragma,
    List<String>? proxyAuthenticate,
    String? proxyAuthorization,
    String? range,
    String? referer,
    String? retryAfter,
    String? server,
    List<String>? te,
    List<String>? trailer,
    List<String>? transferEncoding,
    List<String>? upgrade,
    String? userAgent,
    List<String>? vary,
    List<String>? via,
    List<String>? warning,
    List<String>? wwwAuthenticate,
    CustomHeaders? custom,
  });

  @override
  String toString() {
    var strings = <String>[
      if (date != null) '$_dateHeader: $date',
      if (expires != null) '$_expiresHeader: $expires',
      if (ifModifiedSince != null) '$_ifModifiedSinceHeader: $ifModifiedSince',
      if (from != null) '$_fromHeader: $from',
      if (host != null) '$_hostHeader: $host${port != null ? ':$port' : ''}',
      if (location != null) '$_locationHeader: $location',
      if (xPoweredBy != null) '$_xPoweredByHeader: $xPoweredBy',
      if (accept != null) '$_acceptHeader: ${accept!.join(', ')}',
      if (acceptCharset != null)
        '$_acceptCharsetHeader: ${acceptCharset!.join(', ')}',
      if (acceptEncoding != null)
        '$_acceptEncodingHeader: ${acceptEncoding!.join(', ')}',
      if (acceptLanguage != null)
        '$_acceptLanguageHeader: ${acceptLanguage!.join(', ')}',
      if (acceptRanges != null)
        '$_acceptRangesHeader: ${acceptRanges!.join(', ')}',
      if (accessControlAllowCredentials != null)
        '$_accessControlAllowCredentialsHeader: $accessControlAllowCredentials',
      if (accessControlAllowOrigin != null)
        '$_accessControlAllowOriginHeader: $accessControlAllowOrigin',
      if (accessControlExposeHeaders != null)
        '$_accessControlExposeHeadersHeader: ${accessControlExposeHeaders!.join(', ')}',
      if (accessControlMaxAge != null)
        '$_accessControlMaxAgeHeader: $accessControlMaxAge',
      if (accessControlRequestHeaders != null)
        '$_accessControlRequestHeadersHeader: ${accessControlRequestHeaders!.join(', ')}',
      if (accessControlRequestMethod != null)
        '$_accessControlRequestMethodHeader: $accessControlRequestMethod',
      if (age != null) '$_ageHeader: $age',
      if (allow != null) '$_allowHeader: ${allow!.join(', ')}',
      if (authorization != null) '$authorization',
      if (cacheControl != null)
        '$_cacheControlHeader: ${cacheControl!.join(', ')}',
      if (connection != null) '$_connectionHeader: ${connection!.join(', ')}',
      if (contentEncoding != null)
        '$_contentEncodingHeader: ${contentEncoding!.join(', ')}',
      if (contentLanguage != null)
        '$_contentLanguageHeader: ${contentLanguage!.join(', ')}',
      if (contentLength != null) '$_contentLengthHeader: $contentLength',
      if (contentLocation != null) '$_contentLocationHeader: $contentLocation',
      if (contentMD5 != null) '$_contentMD5Header: $contentMD5',
      if (contentRange != null) '$_contentRangeHeader: $contentRange',
      if (contentType != null) '$_contentTypeHeader: $contentType',
      if (etag != null) '$_etagHeader: $etag',
      if (expect != null) '$_expectHeader: $expect',
      if (ifMatch != null) '$_ifMatchHeader: ${ifMatch!.join(', ')}',
      if (ifNoneMatch != null)
        '$_ifNoneMatchHeader: ${ifNoneMatch!.join(', ')}',
      if (ifRange != null) '$_ifRangeHeader: $ifRange',
      if (ifUnmodifiedSince != null)
        '$_ifUnmodifiedSinceHeader: $ifUnmodifiedSince',
      if (lastModified != null) '$_lastModifiedHeader: $lastModified',
      if (maxForwards != null) '$_maxForwardsHeader: $maxForwards',
      if (mPragma != null) '$_pragmaHeader: $mPragma',
      if (proxyAuthenticate != null)
        ...proxyAuthenticate!
            .map((value) => '$_proxyAuthenticateHeader: $value'),
      if (proxyAuthorization != null)
        '$_proxyAuthorizationHeader: $proxyAuthorization',
      if (range != null) '$_rangeHeader: $range',
      if (referer != null) '$_refererHeader: $referer',
      if (retryAfter != null) '$_retryAfterHeader: $retryAfter',
      if (server != null) '$_serverHeader: $server',
      if (te != null) '$_teHeader: ${te!.join(', ')}',
      if (trailer != null) '$_trailerHeader: ${trailer!.join(', ')}',
      if (transferEncoding != null)
        '$_transferEncodingHeader: ${transferEncoding!.join(', ')}',
      if (upgrade != null) '$_upgradeHeader: ${upgrade!.join(', ')}',
      if (userAgent != null) '$_userAgentHeader: $userAgent',
      if (vary != null) '$_varyHeader: ${vary!.join(', ')}',
      if (via != null) '$_viaHeader: ${via!.join(', ')}',
      if (warning != null)
        ...warning!.map((value) => '$_warningHeader: $value'),
      if (wwwAuthenticate != null)
        ...wwwAuthenticate!.map((value) => '$_wwwAuthenticateHeader: $value'),
      if (contentDisposition != null)
        '$_contentDispositionHeader: $contentDisposition',
      ...custom.entries.map((entry) => '${entry.key}: ${entry.value}'),
    ];

    return strings.join('\n');
  }

  Map<String, Object> toMap() {
    return {
      if (date != null) _dateHeader: '$date',
      if (expires != null) _expiresHeader: '$expires',
      if (ifModifiedSince != null) _ifModifiedSinceHeader: '$ifModifiedSince',
      if (from != null) _fromHeader: from!,
      if (host != null) _hostHeader: port != null ? '$host:$port' : host!,
      if (location != null) _locationHeader: location.toString(),
      if (xPoweredBy != null) _xPoweredByHeader: xPoweredBy!,
      if (accept != null) _acceptHeader: accept!,
      if (acceptCharset != null) _acceptCharsetHeader: acceptCharset!,
      if (acceptEncoding != null) _acceptEncodingHeader: acceptEncoding!,
      if (acceptLanguage != null) _acceptLanguageHeader: acceptLanguage!,
      if (acceptRanges != null) _acceptRangesHeader: acceptRanges!,
      if (accessControlAllowCredentials != null)
        _accessControlAllowCredentialsHeader: accessControlAllowCredentials!,
      if (accessControlAllowOrigin != null)
        _accessControlAllowOriginHeader: accessControlAllowOrigin!,
      if (accessControlExposeHeaders != null)
        _accessControlExposeHeadersHeader: accessControlExposeHeaders!,
      if (accessControlMaxAge != null)
        _accessControlMaxAgeHeader: accessControlMaxAge!,
      if (accessControlRequestHeaders != null)
        _accessControlRequestHeadersHeader: accessControlRequestHeaders!,
      if (accessControlRequestMethod != null)
        _accessControlRequestMethodHeader: accessControlRequestMethod!,
      if (age != null) _ageHeader: age!,
      if (allow != null) _allowHeader: allow!,
      if (authorization != null) _authorizationHeader: authorization.toString(),
      if (cacheControl != null) _cacheControlHeader: cacheControl!,
      if (connection != null) _connectionHeader: connection!,
      if (contentEncoding != null) _contentEncodingHeader: contentEncoding!,
      if (contentLanguage != null) _contentLanguageHeader: contentLanguage!,
      if (contentLength != null) _contentLengthHeader: contentLength!,
      if (contentLocation != null) _contentLocationHeader: contentLocation!,
      if (contentMD5 != null) _contentMD5Header: contentMD5!,
      if (contentRange != null) _contentRangeHeader: contentRange!,
      if (contentType != null) _contentTypeHeader: contentType!,
      if (etag != null) _etagHeader: etag!,
      if (expect != null) _expectHeader: expect!,
      if (ifMatch != null) _ifMatchHeader: ifMatch!,
      if (ifNoneMatch != null) _ifNoneMatchHeader: ifNoneMatch!,
      if (ifRange != null) _ifRangeHeader: ifRange!,
      if (ifUnmodifiedSince != null)
        _ifUnmodifiedSinceHeader: ifUnmodifiedSince!,
      if (lastModified != null) _lastModifiedHeader: lastModified!,
      if (maxForwards != null) _maxForwardsHeader: maxForwards!,
      if (mPragma != null) _pragmaHeader: mPragma!,
      if (proxyAuthenticate != null)
        _proxyAuthenticateHeader: proxyAuthenticate!,
      if (proxyAuthorization != null)
        _proxyAuthorizationHeader: proxyAuthorization!,
      if (range != null) _rangeHeader: range!,
      if (referer != null) _refererHeader: referer!,
      if (retryAfter != null) _retryAfterHeader: retryAfter!,
      if (server != null) _serverHeader: server!,
      if (te != null) _teHeader: te!,
      if (trailer != null) _trailerHeader: trailer!,
      if (transferEncoding != null) _transferEncodingHeader: transferEncoding!,
      if (upgrade != null) _upgradeHeader: upgrade!,
      if (userAgent != null) _userAgentHeader: userAgent!,
      if (vary != null) _varyHeader: vary!,
      if (via != null) _viaHeader: via!,
      if (warning != null) _warningHeader: warning!,
      if (wwwAuthenticate != null) _wwwAuthenticateHeader: wwwAuthenticate!,
      if (contentDisposition != null)
        _contentDispositionHeader: contentDisposition!,
      ...custom,
    };
  }
}

class _HeadersImpl extends Headers {
  _HeadersImpl({
    super.date,
    super.expires,
    super.ifModifiedSince,
    super.from,
    super.host,
    super.port,
    super.location,
    super.xPoweredBy,
    super.accept,
    super.acceptCharset,
    super.acceptEncoding,
    super.acceptLanguage,
    super.acceptRanges,
    super.accessControlAllowCredentials,
    super.accessControlAllowOrigin,
    super.accessControlExposeHeaders,
    super.accessControlMaxAge,
    super.accessControlRequestHeaders,
    super.accessControlRequestMethod,
    super.age,
    super.allow,
    super.contentDisposition,
    super.authorization,
    super.cacheControl,
    super.connection,
    super.contentEncoding,
    super.contentLanguage,
    super.contentLength,
    super.contentLocation,
    super.contentMD5,
    super.contentRange,
    super.contentType,
    super.etag,
    super.expect,
    super.ifMatch,
    super.ifNoneMatch,
    super.ifRange,
    super.ifUnmodifiedSince,
    super.lastModified,
    super.maxForwards,
    super.mPragma,
    super.proxyAuthenticate,
    super.proxyAuthorization,
    super.range,
    super.referer,
    super.retryAfter,
    super.server,
    super.te,
    super.trailer,
    super.transferEncoding,
    super.upgrade,
    super.userAgent,
    super.vary,
    super.via,
    super.warning,
    super.wwwAuthenticate,
    super.custom,
  }) : super._();

  @override
  Headers copyWith({
    Object? date = _Undefined,
    Object? expires = _Undefined,
    Object? ifModifiedSince = _Undefined,
    Object? from = _Undefined,
    Object? host = _Undefined,
    Object? location = _Undefined,
    Object? port = _Undefined,
    Object? xPoweredBy = _Undefined,
    Object? accept = _Undefined,
    Object? acceptCharset = _Undefined,
    Object? acceptEncoding = _Undefined,
    Object? acceptLanguage = _Undefined,
    Object? acceptRanges = _Undefined,
    Object? accessControlAllowCredentials = _Undefined,
    Object? accessControlAllowOrigin = _Undefined,
    Object? accessControlExposeHeaders = _Undefined,
    Object? accessControlMaxAge = _Undefined,
    Object? accessControlRequestHeaders = _Undefined,
    Object? accessControlRequestMethod = _Undefined,
    Object? age = _Undefined,
    Object? allow = _Undefined,
    Object? contentDisposition = _Undefined,
    CustomHeaders? custom,
    AuthorizationHeader? authorization,
    Object? cacheControl = _Undefined,
    Object? connection = _Undefined,
    Object? contentEncoding = _Undefined,
    Object? contentLanguage = _Undefined,
    Object? contentLength = _Undefined,
    Object? contentLocation = _Undefined,
    Object? contentMD5 = _Undefined,
    Object? contentRange = _Undefined,
    Object? contentType = _Undefined,
    Object? etag = _Undefined,
    Object? expect = _Undefined,
    Object? ifMatch = _Undefined,
    Object? ifNoneMatch = _Undefined,
    Object? ifRange = _Undefined,
    Object? ifUnmodifiedSince = _Undefined,
    Object? lastModified = _Undefined,
    Object? maxForwards = _Undefined,
    Object? mPragma = _Undefined,
    Object? proxyAuthenticate = _Undefined,
    Object? proxyAuthorization = _Undefined,
    Object? range = _Undefined,
    Object? referer = _Undefined,
    Object? retryAfter = _Undefined,
    Object? server = _Undefined,
    Object? te = _Undefined,
    Object? trailer = _Undefined,
    Object? transferEncoding = _Undefined,
    Object? upgrade = _Undefined,
    Object? userAgent = _Undefined,
    Object? vary = _Undefined,
    Object? via = _Undefined,
    Object? warning = _Undefined,
    Object? wwwAuthenticate = _Undefined,
  }) {
    return _HeadersImpl(
      date: date is DateTime? ? date : this.date,
      expires: expires is DateTime? ? expires : this.expires,
      ifModifiedSince:
          ifModifiedSince is DateTime? ? ifModifiedSince : this.ifModifiedSince,
      from: from is String? ? from : this.from,
      host: host is String? ? host : this.host,
      port: port is int? ? port : this.port,
      location: location is Uri? ? location : this.location,
      xPoweredBy: xPoweredBy is String? ? xPoweredBy : this.xPoweredBy,
      accept: accept is List<String> ? accept : this.accept,
      acceptCharset:
          acceptCharset is List<String> ? acceptCharset : this.acceptCharset,
      acceptEncoding:
          acceptEncoding is List<String> ? acceptEncoding : this.acceptEncoding,
      acceptLanguage:
          acceptLanguage is List<String> ? acceptLanguage : this.acceptLanguage,
      acceptRanges:
          acceptRanges is List<String> ? acceptRanges : this.acceptRanges,
      accessControlAllowCredentials: accessControlAllowCredentials is String
          ? accessControlAllowCredentials
          : this.accessControlAllowCredentials,
      accessControlAllowOrigin: accessControlAllowOrigin is String
          ? accessControlAllowOrigin
          : this.accessControlAllowOrigin,
      accessControlExposeHeaders: accessControlExposeHeaders is List<String>
          ? accessControlExposeHeaders
          : this.accessControlExposeHeaders,
      accessControlMaxAge: accessControlMaxAge is String
          ? accessControlMaxAge
          : this.accessControlMaxAge,
      accessControlRequestHeaders: accessControlRequestHeaders is List<String>
          ? accessControlRequestHeaders
          : this.accessControlRequestHeaders,
      accessControlRequestMethod: accessControlRequestMethod is String
          ? accessControlRequestMethod
          : this.accessControlRequestMethod,
      age: age is String ? age : this.age,
      allow: allow is List<String> ? allow : this.allow,
      contentDisposition: contentDisposition is String
          ? contentDisposition
          : this.contentDisposition,
      authorization: authorization ?? this.authorization,
      cacheControl:
          cacheControl is List<String> ? cacheControl : this.cacheControl,
      connection: connection is List<String> ? connection : this.connection,
      contentEncoding: contentEncoding is List<String>
          ? contentEncoding
          : this.contentEncoding,
      contentLanguage: contentLanguage is List<String>
          ? contentLanguage
          : this.contentLanguage,
      contentLength:
          contentLength is String ? contentLength : this.contentLength,
      contentLocation:
          contentLocation is String ? contentLocation : this.contentLocation,
      contentMD5: contentMD5 is String ? contentMD5 : this.contentMD5,
      contentRange: contentRange is String ? contentRange : this.contentRange,
      contentType: contentType is String ? contentType : this.contentType,
      etag: etag is String ? etag : this.etag,
      expect: expect is String ? expect : this.expect,
      ifMatch: ifMatch is List<String> ? ifMatch : this.ifMatch,
      ifNoneMatch: ifNoneMatch is List<String> ? ifNoneMatch : this.ifNoneMatch,
      ifRange: ifRange is String ? ifRange : this.ifRange,
      ifUnmodifiedSince: ifUnmodifiedSince is String
          ? ifUnmodifiedSince
          : this.ifUnmodifiedSince,
      lastModified: lastModified is String ? lastModified : this.lastModified,
      maxForwards: maxForwards is String ? maxForwards : this.maxForwards,
      mPragma: mPragma is String ? mPragma : this.mPragma,
      proxyAuthenticate: proxyAuthenticate is List<String>
          ? proxyAuthenticate
          : this.proxyAuthenticate,
      proxyAuthorization: proxyAuthorization is String
          ? proxyAuthorization
          : this.proxyAuthorization,
      range: range is String ? range : this.range,
      referer: referer is String ? referer : this.referer,
      retryAfter: retryAfter is String ? retryAfter : this.retryAfter,
      server: server is String ? server : this.server,
      te: te is List<String> ? te : this.te,
      trailer: trailer is List<String> ? trailer : this.trailer,
      transferEncoding: transferEncoding is List<String>
          ? transferEncoding
          : this.transferEncoding,
      upgrade: upgrade is List<String> ? upgrade : this.upgrade,
      userAgent: userAgent is String ? userAgent : this.userAgent,
      vary: vary is List<String> ? vary : this.vary,
      via: via is List<String> ? via : this.via,
      warning: warning is List<String> ? warning : this.warning,
      wwwAuthenticate: wwwAuthenticate is List<String>
          ? wwwAuthenticate
          : this.wwwAuthenticate,
      custom: custom ?? this.custom,
    );
  }
}

class _Undefined {}
