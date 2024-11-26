part of '../headers.dart';

/// A class representing the HTTP `From` header.
///
/// The `From` header is used to indicate the email address of the user making the request.
/// It usually contains a single email address, but in edge cases, it could contain multiple
/// email addresses separated by commas.
class FromHeader {
  /// A list of email addresses provided in the `From` header.
  final List<String> emails;

  /// Private constructor for initializing the [emails] list.
  FromHeader({required this.emails});

  /// Parses a `From` header value and returns a [FromHeader] instance.
  factory FromHeader.parse(List<String> values) {
    var emails = values.splitTrimAndFilterUnique();
    if (emails.isEmpty) {
      throw FormatException('Value cannot be empty');
    }

    for (var email in emails) {
      if (!email.isValidEmail()) {
        throw FormatException('Invalid email format');
      }
    }

    return FromHeader(emails: emails);
  }

  /// Returns the single email address if the list only contains one email.
  String? get singleEmail => emails.length == 1 ? emails.first : null;

  /// Converts the [FromHeader] instance into a string representation suitable for HTTP headers.
  ///
  /// This method joins the email addresses with commas (`,`) if there are multiple addresses.
  String toHeaderString() => emails.join(', ');

  @override
  String toString() {
    return 'FromHeader(emails: $emails)';
  }
}