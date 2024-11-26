part of '../headers.dart';

final _emptyCustomHeaders = CustomHeaders._empty();

/// CustomHeaders is a case-insensitive, unmodifiable map that stores headers
/// which are not part of the predefined standard headers in the [Headers] class.
/// This allows the addition of any non-standard or "custom" headers, enabling
/// flexibility for handling unknown or vendor-specific headers.
/// CustomHeaders ensures that even if the header is not natively supported,
/// it can still be processed and included in requests or responses.
class CustomHeaders extends UnmodifiableMapView<String, List<String>> {
  /// Creates an empty instance of [CustomHeaders].
  factory CustomHeaders.empty() => _emptyCustomHeaders;

  /// Creates an instance of [CustomHeaders] with the given [values].
  factory CustomHeaders(Map<String, List<String>> values) {
    return CustomHeaders._(
      values.entries.map((e) => MapEntry(e.key, e.value)),
    );
  }

  CustomHeaders._empty() : super(const {});

  /// Creates an instance of [CustomHeaders] from [io.HttpHeaders].
  ///
  /// [excludedHeaders] is a set of headers that should be excluded.
  factory CustomHeaders._fromHttpHeaders(
    io.HttpHeaders headers, {
    Set<String> excludedHeaders = const {},
  }) {
    var custom = <MapEntry<String, List<String>>>[];

    headers.forEach((name, values) {
      // Skip headers that we support natively.
      if (excludedHeaders.contains(name.toLowerCase())) {
        return;
      }

      custom.add(MapEntry(
        name,
        values.fold(
          [],
          (a, b) => [
            ...a,
            ...b.split(',').map((e) => e.trim()).where((e) => e.isNotEmpty)
          ],
        ),
      ));
    });

    if (custom.isEmpty) return _emptyCustomHeaders;

    return CustomHeaders._(custom);
  }

  CustomHeaders._(
    Iterable<MapEntry<String, List<String>>> entries,
  ) : super(_toCaseInsensitiveMap(entries));

  /// Adds a new header or updates an existing one.
  CustomHeaders add(String key, List<String> values) {
    var updatedHeaders = Map<String, List<String>>.from(this);
    updatedHeaders[key] = values;
    return CustomHeaders(updatedHeaders);
  }

  /// Removes a header by its key.
  CustomHeaders removeKey(String key) {
    var updatedHeaders = Map<String, List<String>>.from(this);
    updatedHeaders.remove(key);
    return CustomHeaders(updatedHeaders);
  }

  /// Creates a copy of this instance with optional modifications.
  ///
  /// You can pass in a map of updated or new headers that will
  /// be added to the new instance.
  CustomHeaders copyWith({
    Map<String, List<String>>? newHeaders,
  }) {
    var updatedHeaders = Map<String, List<String>>.from(this);

    newHeaders?.forEach((key, value) {
      updatedHeaders[key] = value;
    });

    return CustomHeaders(updatedHeaders);
  }

  /// Sets headers from another `CustomHeaders` instance.
  CustomHeaders _withOther(CustomHeaders other) {
    if (other.isEmpty) return this;

    // Create a new map with all entries from the current instance.
    var mergedEntries = Map<String, List<String>>.from(this);

    // Add/override entries from the other instance.
    other.forEach((key, value) {
      mergedEntries[key] = List<String>.from(value);
    });

    return CustomHeaders(mergedEntries);
  }
}

/// Converts a list of [MapEntry] to a case-insensitive map.
CaseInsensitiveMap<List<String>> _toCaseInsensitiveMap(
  Iterable<MapEntry<String, List<String>>> entries,
) {
  final validEntries = entries
      .where((entry) => entry.value.isNotEmpty)
      .map((entry) => MapEntry(entry.key, _withNoEmptyValues(entry.value)));

  return CaseInsensitiveMap.from(
    Map.fromEntries(
      validEntries.map(
        (e) => MapEntry(
          e.key,
          List.unmodifiable(e.value),
        ),
      ),
    ),
  );
}

/// Filters out empty values from a list of strings.
List<String> _withNoEmptyValues(List<String> values) =>
    values.where((value) => value.isNotEmpty).toList();