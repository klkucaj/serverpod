import 'package:serverpod/src/database/extensions.dart';
import 'package:serverpod/src/database/migrations/table_comparison_warning.dart';
import 'package:test/test.dart';
import 'package:serverpod/protocol.dart';

void main() {
  group('Given tables with different columns', () {
    test(
      'when a column is missing in the target table then mismatches include missing column',
      () {
        var tableA = TableDefinition(
          name: 'test_table',
          schema: 'public',
          columns: [
            ColumnDefinition(
              name: 'id',
              columnType: ColumnType.integer,
              isNullable: false,
              dartType: 'int',
            ),
            ColumnDefinition(
              name: 'age',
              columnType: ColumnType.integer,
              isNullable: true,
              dartType: 'int?',
            ),
          ],
          foreignKeys: [],
          indexes: [],
          managed: true,
        );

        var tableB = TableDefinition(
          name: 'test_table',
          schema: 'public',
          columns: [
            ColumnDefinition(
              name: 'id',
              columnType: ColumnType.integer,
              isNullable: false,
              dartType: 'int',
            ),
          ],
          foreignKeys: [],
          indexes: [],
          managed: true,
        );

        var mismatches = tableA.like(tableB);

        expect(mismatches.length, 1);
        expect(mismatches.first.subs, isEmpty);

        expect(mismatches.first, isA<ColumnComparisonWarning>());
        expect(mismatches.first.mismatch, equals('missing'));
        expect(mismatches.first.expected, equals('age'));
        expect(mismatches.first.found, equals('none'));
      },
    );

    test(
      'when the target table has an extra column then mismatches include extra column',
      () {
        var tableA = TableDefinition(
          name: 'test_table',
          schema: 'public',
          columns: [
            ColumnDefinition(
              name: 'id',
              columnType: ColumnType.integer,
              isNullable: false,
              dartType: 'int',
            ),
          ],
          foreignKeys: [],
          indexes: [],
          managed: true,
        );

        var tableB = TableDefinition(
          name: 'test_table',
          schema: 'public',
          columns: [
            ColumnDefinition(
              name: 'id',
              columnType: ColumnType.integer,
              isNullable: false,
              dartType: 'int',
            ),
            ColumnDefinition(
              name: 'name',
              columnType: ColumnType.text,
              isNullable: false,
              dartType: 'String',
            ),
          ],
          foreignKeys: [],
          indexes: [],
          managed: true,
        );

        var mismatches = tableA.like(tableB);

        expect(mismatches.length, 1);
        expect(mismatches.first.subs, isEmpty);

        expect(mismatches.first, isA<ColumnComparisonWarning>());
        expect(mismatches.first.mismatch, equals('extra'));
        expect(mismatches.first.found, equals('name'));
        expect(mismatches.first.expected, equals('none'));
      },
    );

    test(
      'when columns have different types then mismatches include column type mismatch',
      () {
        var tableA = TableDefinition(
          name: 'test_table',
          schema: 'public',
          columns: [
            ColumnDefinition(
              name: 'value',
              columnType: ColumnType.integer,
              isNullable: false,
              dartType: 'int',
            ),
          ],
          foreignKeys: [],
          indexes: [],
          managed: true,
        );

        var tableB = TableDefinition(
          name: 'test_table',
          schema: 'public',
          columns: [
            ColumnDefinition(
              name: 'value',
              columnType: ColumnType.text,
              isNullable: false,
              dartType: 'String',
            ),
          ],
          foreignKeys: [],
          indexes: [],
          managed: true,
        );

        var mismatches = tableA.like(tableB);

        expect(mismatches.length, 1);
        expect(mismatches.first.subs, isNotEmpty);

        expect(mismatches.first, isA<ColumnComparisonWarning>());
        expect(mismatches.first.subs.first.mismatch, equals('type'));
        expect(mismatches.first.subs.first.expected, equals('integer'));
        expect(mismatches.first.subs.first.found, equals('text'));
      },
    );

    test(
      'when columns have different nullability then mismatches include column nullability mismatch',
      () {
        var tableA = TableDefinition(
          name: 'test_table',
          schema: 'public',
          columns: [
            ColumnDefinition(
              name: 'name',
              columnType: ColumnType.text,
              isNullable: false,
              dartType: 'String',
            ),
          ],
          foreignKeys: [],
          indexes: [],
          managed: true,
        );

        var tableB = TableDefinition(
          name: 'test_table',
          schema: 'public',
          columns: [
            ColumnDefinition(
              name: 'name',
              columnType: ColumnType.text,
              isNullable: true,
              dartType: 'String?',
            ),
          ],
          foreignKeys: [],
          indexes: [],
          managed: true,
        );

        var mismatches = tableA.like(tableB);

        expect(mismatches.length, 1);
        expect(mismatches.first.subs, isNotEmpty);

        expect(mismatches.first, isA<ColumnComparisonWarning>());
        expect(mismatches.first.subs.first.mismatch, equals('nullability'));
        expect(mismatches.first.subs.first.expected, equals('false'));
        expect(mismatches.first.subs.first.found, equals('true'));
      },
    );

    test(
      'when columns have different default values then mismatches include default value mismatch',
      () {
        var tableA = TableDefinition(
          name: 'test_table',
          schema: 'public',
          columns: [
            ColumnDefinition(
              name: 'id',
              columnType: ColumnType.integer,
              isNullable: false,
              dartType: 'int',
              columnDefault: '1',
            ),
          ],
          foreignKeys: [],
          indexes: [],
          managed: true,
        );

        var tableB = TableDefinition(
          name: 'test_table',
          schema: 'public',
          columns: [
            ColumnDefinition(
              name: 'id',
              columnType: ColumnType.integer,
              isNullable: false,
              dartType: 'int',
              columnDefault: '2',
            ),
          ],
          foreignKeys: [],
          indexes: [],
          managed: true,
        );

        var mismatches = tableA.like(tableB);

        expect(mismatches.length, 1);
        expect(mismatches.first.subs, isNotEmpty);

        expect(mismatches.first, isA<ColumnComparisonWarning>());
        expect(mismatches.first.subs.first.mismatch, equals('default value'));
        expect(mismatches.first.subs.first.expected, equals('1'));
        expect(mismatches.first.subs.first.found, equals('2'));
      },
    );
  });
}
