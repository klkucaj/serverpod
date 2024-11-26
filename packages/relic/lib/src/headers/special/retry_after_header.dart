part of '../headers.dart';

/// A class representing the HTTP Retry-After header.
///
/// This class manages both date-based and delay-based retry values.
/// The Retry-After header can contain either an HTTP date or a delay in seconds
/// indicating when the client should retry the request.
class RetryAfterHeader {
  /// The retry delay in seconds, if present.
  final int? delay;

  /// The retry date, if present.
  final DateTime? date;

  /// Constructs a [RetryAfterHeader] instance with either a delay in seconds or a date.
  const RetryAfterHeader({
    this.delay,
    this.date,
  })  : assert(
          delay != null || date != null,
          'Either delay or date must be specified',
        ),
        assert(
          !(delay != null && date != null),
          'Both delay and date cannot be specified at the same time',
        );

  /// Parses the Retry-After header value and returns a [RetryAfterHeader] instance.
  ///
  /// This method checks if the value is an integer (for delay) or a date string.
  factory RetryAfterHeader.parse(String value) {
    final trimmed = value.trim();
    if (trimmed.isEmpty) {
      throw FormatException('Value cannot be empty');
    }

    var delay = int.tryParse(trimmed);
    if (delay != null) {
      if (delay < 0) {
        throw FormatException('Delay cannot be negative');
      }
      return RetryAfterHeader(delay: delay);
    } else {
      try {
        final date = parseHttpDate(trimmed);
        return RetryAfterHeader(date: date);
      } catch (e) {
        throw FormatException('Invalid date format');
      }
    }
  }

  /// Converts the [RetryAfterHeader] instance into a string representation suitable for HTTP headers.
  String toHeaderString() {
    if (delay != null) {
      return delay.toString();
    }
    if (date != null) {
      return formatHttpDate(date!);
    }
    return '';
  }

  @override
  String toString() {
    return 'RetryAfterHeader(delay: $delay, date: $date)';
  }
}