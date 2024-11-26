part of '../headers.dart';

/// A class representing the HTTP Content-Encoding header.
///
/// This class manages content encodings such as `gzip`, `compress`, `deflate`,
/// `br`, and `identity`. It provides functionality to parse and generate
/// content encoding header values.
class ContentEncodingHeader {
  /// A list of content encodings.
  final List<ContentEncoding> encodings;

  /// Constructs a [ContentEncodingHeader] instance with the specified content
  /// encodings.
  const ContentEncodingHeader({
    required this.encodings,
  });

  /// Parses the Content-Encoding header value and returns a
  /// [ContentEncodingHeader] instance.
  ///
  /// This method splits the value by commas and trims each encoding.
  factory ContentEncodingHeader.parse(List<String> values) {
    var splitValues = values.splitTrimAndFilterUnique();
    if (splitValues.isEmpty) {
      throw FormatException('Value cannot be empty');
    }

    var parsedEncodings =
        splitValues.map((e) => ContentEncoding.parse(e)).toList();

    return ContentEncodingHeader(encodings: parsedEncodings);
  }

  /// Checks if the Content-Encoding contains a specific encoding.
  bool containsEncoding(ContentEncoding encoding) {
    return encodings.contains(encoding);
  }

  /// Converts the [ContentEncodingHeader] instance into a string representation
  /// suitable for HTTP headers.
  String toHeaderString() => encodings.map((e) => e.name).join(', ');

  @override
  String toString() {
    return 'ContentEncodingHeader(encodings: $encodings)';
  }
}

/// A class representing valid content encodings.
class ContentEncoding {
  /// The string representation of the content encoding.
  final String name;

  /// Constructs a [ContentEncoding] instance with the specified name.
  const ContentEncoding(this.name);

  /// Predefined content encodings.
  static const _gzip = 'gzip';
  static const _compress = 'compress';
  static const _deflate = 'deflate';
  static const _br = 'br';
  static const _identity = 'identity';
  static const _zstd = 'zstd';

  static const gzip = ContentEncoding(_gzip);
  static const compress = ContentEncoding(_compress);
  static const deflate = ContentEncoding(_deflate);
  static const br = ContentEncoding(_br);
  static const identity = ContentEncoding(_identity);
  static const zstd = ContentEncoding(_zstd);

  /// Parses a [name] and returns the corresponding [ContentEncoding] instance.
  /// If the name does not match any predefined encodings, it returns a custom
  /// instance.
  factory ContentEncoding.parse(String name) {
    final trimmed = name.trim();
    if (trimmed.isEmpty) {
      throw FormatException('Name cannot be empty');
    }
    switch (trimmed.toLowerCase()) {
      case _gzip:
        return gzip;
      case _compress:
        return compress;
      case _deflate:
        return deflate;
      case _br:
        return br;
      case _identity:
        return identity;
      case _zstd:
        return zstd;
      default:
        return ContentEncoding(trimmed);
    }
  }

  /// Returns the string representation of the content encoding.
  String toHeaderString() => name;

  @override
  String toString() => 'ContentEncoding(name: $name)';
}