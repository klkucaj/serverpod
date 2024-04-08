/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: public_member_api_docs
// ignore_for_file: implementation_imports
// ignore_for_file: use_super_parameters
// ignore_for_file: type_literal_in_constant_pattern

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:serverpod/serverpod.dart' as _i1;
import 'protocol.dart' as _i2;
import 'dart:typed_data' as _i3;
import 'package:uuid/uuid_value.dart' as _i4;
import 'package:serverpod_serialization/serverpod_serialization.dart';

abstract class ObjectWithMaps extends _i1.SerializableEntity {
  ObjectWithMaps._({
    required this.dataMap,
    required this.intMap,
    required this.stringMap,
    required this.dateTimeMap,
    required this.byteDataMap,
    required this.durationMap,
    required this.uuidMap,
    required this.nullableDataMap,
    required this.nullableIntMap,
    required this.nullableStringMap,
    required this.nullableDateTimeMap,
    required this.nullableByteDataMap,
    required this.nullableDurationMap,
    required this.nullableUuidMap,
    required this.intIntMap,
  });

  factory ObjectWithMaps({
    required Map<String, _i2.SimpleData> dataMap,
    required Map<String, int> intMap,
    required Map<String, String> stringMap,
    required Map<String, DateTime> dateTimeMap,
    required Map<String, _i3.ByteData> byteDataMap,
    required Map<String, Duration> durationMap,
    required Map<String, _i1.UuidValue> uuidMap,
    required Map<String, _i2.SimpleData?> nullableDataMap,
    required Map<String, int?> nullableIntMap,
    required Map<String, String?> nullableStringMap,
    required Map<String, DateTime?> nullableDateTimeMap,
    required Map<String, _i3.ByteData?> nullableByteDataMap,
    required Map<String, Duration?> nullableDurationMap,
    required Map<String, _i1.UuidValue?> nullableUuidMap,
    required Map<int, int> intIntMap,
  }) = _ObjectWithMapsImpl;

  factory ObjectWithMaps.fromJson(Map<String, dynamic> jsonSerialization) {
    return ObjectWithMaps(
      dataMap: (jsonSerialization['dataMap'] as List<dynamic>)
          .fold<Map<String, _i2.SimpleData>>(
              {},
              (t, e) => {
                    ...t,
                    e['k'] as String:
                        _i2.SimpleData.fromJson(e['v'] as Map<String, dynamic>)
                  }),
      intMap: (jsonSerialization['intMap'] as List<dynamic>)
          .fold<Map<String, int>>(
              {}, (t, e) => {...t, e['k'] as String: e['v'] as int}),
      stringMap: (jsonSerialization['stringMap'] as List<dynamic>)
          .fold<Map<String, String>>(
              {}, (t, e) => {...t, e['k'] as String: e['v'] as String}),
      dateTimeMap: (jsonSerialization['dateTimeMap'] as List<dynamic>)
          .fold<Map<String, DateTime>>(
              {},
              (t, e) =>
                  {...t, e['k'] as String: DateTime.parse((e['v'] as String))}),
      byteDataMap: (jsonSerialization['byteDataMap'] as List<dynamic>)
          .fold<Map<String, _i3.ByteData>>(
              {},
              (t, e) => {
                    ...t,
                    e['k'] as String: (e['v'] != null && e['v'] is _i3.Uint8List
                        ? _i3.ByteData.view(
                            e['v'].buffer,
                            e['v'].offsetInBytes,
                            e['v'].lengthInBytes,
                          )
                        : (e['v'] as String?)?.base64DecodedByteData())!
                  }),
      durationMap: (jsonSerialization['durationMap'] as List<dynamic>)
          .fold<Map<String, Duration>>(
              {},
              (t, e) =>
                  {...t, e['k'] as String: Duration(milliseconds: e['v'])}),
      uuidMap: (jsonSerialization['uuidMap'] as List<dynamic>)
          .fold<Map<String, _i1.UuidValue>>(
              {},
              (t, e) =>
                  {...t, e['k'] as String: _i4.UuidValue.fromString(e['v'])}),
      nullableDataMap: (jsonSerialization['nullableDataMap'] as List<dynamic>)
          .fold<Map<String, _i2.SimpleData?>>(
              {},
              (t, e) => {
                    ...t,
                    e['k'] as String:
                        _i2.SimpleData.fromJson(e['v'] as Map<String, dynamic>)
                  }),
      nullableIntMap: (jsonSerialization['nullableIntMap'] as List<dynamic>)
          .fold<Map<String, int?>>(
              {}, (t, e) => {...t, e['k'] as String: e['v'] as int?}),
      nullableStringMap:
          (jsonSerialization['nullableStringMap'] as List<dynamic>)
              .fold<Map<String, String?>>(
                  {}, (t, e) => {...t, e['k'] as String: e['v'] as String?}),
      nullableDateTimeMap: (jsonSerialization['nullableDateTimeMap']
              as List<dynamic>)
          .fold<Map<String, DateTime?>>(
              {},
              (t, e) =>
                  {...t, e['k'] as String: DateTime.tryParse(e['v'] ?? '')}),
      nullableByteDataMap:
          (jsonSerialization['nullableByteDataMap'] as List<dynamic>)
              .fold<Map<String, _i3.ByteData?>>(
                  {},
                  (t, e) => {
                        ...t,
                        e['k'] as String: e['v'] is _i3.Uint8List
                            ? _i3.ByteData.view(
                                e['v'].buffer,
                                e['v'].offsetInBytes,
                                e['v'].lengthInBytes,
                              )
                            : (e['v'] as String?)?.base64DecodedByteData()
                      }),
      nullableDurationMap:
          (jsonSerialization['nullableDurationMap'] as List<dynamic>)
              .fold<Map<String, Duration?>>(
                  {},
                  (t, e) =>
                      {...t, e['k'] as String: Duration(milliseconds: e['v'])}),
      nullableUuidMap: (jsonSerialization['nullableUuidMap'] as List<dynamic>)
          .fold<Map<String, _i1.UuidValue?>>(
              {},
              (t, e) =>
                  {...t, e['k'] as String: _i4.UuidValue.fromString(e['v'])}),
      intIntMap: (jsonSerialization['intIntMap'] as List<dynamic>)
          .fold<Map<int, int>>(
              {}, (t, e) => {...t, e['k'] as int: e['v'] as int}),
    );
  }

  Map<String, _i2.SimpleData> dataMap;

  Map<String, int> intMap;

  Map<String, String> stringMap;

  Map<String, DateTime> dateTimeMap;

  Map<String, _i3.ByteData> byteDataMap;

  Map<String, Duration> durationMap;

  Map<String, _i1.UuidValue> uuidMap;

  Map<String, _i2.SimpleData?> nullableDataMap;

  Map<String, int?> nullableIntMap;

  Map<String, String?> nullableStringMap;

  Map<String, DateTime?> nullableDateTimeMap;

  Map<String, _i3.ByteData?> nullableByteDataMap;

  Map<String, Duration?> nullableDurationMap;

  Map<String, _i1.UuidValue?> nullableUuidMap;

  Map<int, int> intIntMap;

  ObjectWithMaps copyWith({
    Map<String, _i2.SimpleData>? dataMap,
    Map<String, int>? intMap,
    Map<String, String>? stringMap,
    Map<String, DateTime>? dateTimeMap,
    Map<String, _i3.ByteData>? byteDataMap,
    Map<String, Duration>? durationMap,
    Map<String, _i1.UuidValue>? uuidMap,
    Map<String, _i2.SimpleData?>? nullableDataMap,
    Map<String, int?>? nullableIntMap,
    Map<String, String?>? nullableStringMap,
    Map<String, DateTime?>? nullableDateTimeMap,
    Map<String, _i3.ByteData?>? nullableByteDataMap,
    Map<String, Duration?>? nullableDurationMap,
    Map<String, _i1.UuidValue?>? nullableUuidMap,
    Map<int, int>? intIntMap,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      'dataMap': dataMap.toJson(valueToJson: (v) => v.toJson()),
      'intMap': intMap.toJson(),
      'stringMap': stringMap.toJson(),
      'dateTimeMap': dateTimeMap.toJson(valueToJson: (v) => v.toJson()),
      'byteDataMap': byteDataMap.toJson(valueToJson: (v) => v.toJson()),
      'durationMap': durationMap.toJson(valueToJson: (v) => v.toJson()),
      'uuidMap': uuidMap.toJson(valueToJson: (v) => v.toJson()),
      'nullableDataMap':
          nullableDataMap.toJson(valueToJson: (v) => v?.toJson()),
      'nullableIntMap': nullableIntMap.toJson(),
      'nullableStringMap': nullableStringMap.toJson(),
      'nullableDateTimeMap':
          nullableDateTimeMap.toJson(valueToJson: (v) => v?.toJson()),
      'nullableByteDataMap':
          nullableByteDataMap.toJson(valueToJson: (v) => v?.toJson()),
      'nullableDurationMap':
          nullableDurationMap.toJson(valueToJson: (v) => v?.toJson()),
      'nullableUuidMap':
          nullableUuidMap.toJson(valueToJson: (v) => v?.toJson()),
      'intIntMap': intIntMap.toJson(),
    };
  }

  @override
  Map<String, dynamic> allToJson() {
    return {
      'dataMap': dataMap.toJson(valueToJson: (v) => v.allToJson()),
      'intMap': intMap.toJson(),
      'stringMap': stringMap.toJson(),
      'dateTimeMap': dateTimeMap.toJson(valueToJson: (v) => v.toJson()),
      'byteDataMap': byteDataMap.toJson(valueToJson: (v) => v.toJson()),
      'durationMap': durationMap.toJson(valueToJson: (v) => v.toJson()),
      'uuidMap': uuidMap.toJson(valueToJson: (v) => v.toJson()),
      'nullableDataMap':
          nullableDataMap.toJson(valueToJson: (v) => v?.allToJson()),
      'nullableIntMap': nullableIntMap.toJson(),
      'nullableStringMap': nullableStringMap.toJson(),
      'nullableDateTimeMap':
          nullableDateTimeMap.toJson(valueToJson: (v) => v?.toJson()),
      'nullableByteDataMap':
          nullableByteDataMap.toJson(valueToJson: (v) => v?.toJson()),
      'nullableDurationMap':
          nullableDurationMap.toJson(valueToJson: (v) => v?.toJson()),
      'nullableUuidMap':
          nullableUuidMap.toJson(valueToJson: (v) => v?.toJson()),
      'intIntMap': intIntMap.toJson(),
    };
  }
}

class _ObjectWithMapsImpl extends ObjectWithMaps {
  _ObjectWithMapsImpl({
    required Map<String, _i2.SimpleData> dataMap,
    required Map<String, int> intMap,
    required Map<String, String> stringMap,
    required Map<String, DateTime> dateTimeMap,
    required Map<String, _i3.ByteData> byteDataMap,
    required Map<String, Duration> durationMap,
    required Map<String, _i1.UuidValue> uuidMap,
    required Map<String, _i2.SimpleData?> nullableDataMap,
    required Map<String, int?> nullableIntMap,
    required Map<String, String?> nullableStringMap,
    required Map<String, DateTime?> nullableDateTimeMap,
    required Map<String, _i3.ByteData?> nullableByteDataMap,
    required Map<String, Duration?> nullableDurationMap,
    required Map<String, _i1.UuidValue?> nullableUuidMap,
    required Map<int, int> intIntMap,
  }) : super._(
          dataMap: dataMap,
          intMap: intMap,
          stringMap: stringMap,
          dateTimeMap: dateTimeMap,
          byteDataMap: byteDataMap,
          durationMap: durationMap,
          uuidMap: uuidMap,
          nullableDataMap: nullableDataMap,
          nullableIntMap: nullableIntMap,
          nullableStringMap: nullableStringMap,
          nullableDateTimeMap: nullableDateTimeMap,
          nullableByteDataMap: nullableByteDataMap,
          nullableDurationMap: nullableDurationMap,
          nullableUuidMap: nullableUuidMap,
          intIntMap: intIntMap,
        );

  @override
  ObjectWithMaps copyWith({
    Map<String, _i2.SimpleData>? dataMap,
    Map<String, int>? intMap,
    Map<String, String>? stringMap,
    Map<String, DateTime>? dateTimeMap,
    Map<String, _i3.ByteData>? byteDataMap,
    Map<String, Duration>? durationMap,
    Map<String, _i1.UuidValue>? uuidMap,
    Map<String, _i2.SimpleData?>? nullableDataMap,
    Map<String, int?>? nullableIntMap,
    Map<String, String?>? nullableStringMap,
    Map<String, DateTime?>? nullableDateTimeMap,
    Map<String, _i3.ByteData?>? nullableByteDataMap,
    Map<String, Duration?>? nullableDurationMap,
    Map<String, _i1.UuidValue?>? nullableUuidMap,
    Map<int, int>? intIntMap,
  }) {
    return ObjectWithMaps(
      dataMap: dataMap ?? this.dataMap.clone(),
      intMap: intMap ?? this.intMap.clone(),
      stringMap: stringMap ?? this.stringMap.clone(),
      dateTimeMap: dateTimeMap ?? this.dateTimeMap.clone(),
      byteDataMap: byteDataMap ?? this.byteDataMap.clone(),
      durationMap: durationMap ?? this.durationMap.clone(),
      uuidMap: uuidMap ?? this.uuidMap.clone(),
      nullableDataMap: nullableDataMap ?? this.nullableDataMap.clone(),
      nullableIntMap: nullableIntMap ?? this.nullableIntMap.clone(),
      nullableStringMap: nullableStringMap ?? this.nullableStringMap.clone(),
      nullableDateTimeMap:
          nullableDateTimeMap ?? this.nullableDateTimeMap.clone(),
      nullableByteDataMap:
          nullableByteDataMap ?? this.nullableByteDataMap.clone(),
      nullableDurationMap:
          nullableDurationMap ?? this.nullableDurationMap.clone(),
      nullableUuidMap: nullableUuidMap ?? this.nullableUuidMap.clone(),
      intIntMap: intIntMap ?? this.intIntMap.clone(),
    );
  }
}
