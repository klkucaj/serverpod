import 'package:analyzer/dart/analysis/utilities.dart';
import 'package:analyzer/dart/ast/ast.dart';
import 'package:serverpod_cli/src/generator/dart/server_code_generator.dart';
import 'package:serverpod_cli/src/test_util/builders/serializable_entity_field_definition_builder.dart';
import 'package:serverpod_cli/src/test_util/compilation_unit_helpers.dart';
import 'package:test/test.dart';
import 'package:path/path.dart' as path;
import 'package:serverpod_cli/src/test_util/builders/class_definition_builder.dart';
import 'package:serverpod_cli/src/test_util/builders/generator_config_builder.dart';

const projectName = 'example_project';
final config = GeneratorConfigBuilder().withName(projectName).build();
const generator = DartServerCodeGenerator();

void main() {
  group(
      'Given a class named DurationDefault with Duration fields having defaultModelValue when generating code',
      () {
    ClassDeclaration? baseClass;
    ConstructorDeclaration? privateConstructor;

    setUpAll(() {
      var testClassName = 'DurationDefault';
      var testClassFileName = 'duration_default';
      var expectedFilePath =
          path.join('lib', 'src', 'generated', '$testClassFileName.dart');

      var fields = [
        FieldDefinitionBuilder()
            .withName('durationDefault')
            .withTypeDefinition('Duration', false)
            .withDefaults(defaultModelValue: '1d 2h 10min 30s 100ms')
            .build(),
        FieldDefinitionBuilder()
            .withName('durationDefaultNull')
            .withTypeDefinition('Duration', true)
            .withDefaults(defaultModelValue: '2d 1h 20min 40s 100ms')
            .build(),
      ];

      var models = [
        ClassDefinitionBuilder()
            .withClassName(testClassName)
            .withFileName(testClassFileName)
            .withFields(fields)
            .build()
      ];

      var codeMap = generator.generateSerializableModelsCode(
        models: models,
        config: config,
      );

      var compilationUnit =
          parseString(content: codeMap[expectedFilePath]!).unit;

      baseClass = CompilationUnitHelpers.tryFindClassDeclaration(
        compilationUnit,
        name: testClassName,
      );

      privateConstructor = CompilationUnitHelpers.tryFindConstructorDeclaration(
        baseClass!,
        name: '_',
      );
    });

    group('then the DurationDefault has a private constructor', () {
      test('defined', () {
        expect(privateConstructor, isNotNull);
      });

      test(
        'with the class vars as params',
        () {
          expect(
            privateConstructor?.parameters.toSource(),
            '({Duration? durationDefault, Duration? durationDefaultNull})',
          );
        },
      );

      test(
        'with durationDefault default value set correctly',
        () {
          var initializer = privateConstructor?.initializers
              .firstWhere((e) => e.toSource().contains('durationDefault'));
          expect(
            initializer?.toSource(),
            'durationDefault = durationDefault ?? Duration(days: 1, hours: 2, minutes: 10, seconds: 30, milliseconds: 100)',
          );
        },
      );

      test(
        'with durationDefaultNull default value set correctly',
        () {
          var initializer = privateConstructor?.initializers
              .firstWhere((e) => e.toSource().contains('durationDefaultNull'));
          expect(
            initializer?.toSource(),
            'durationDefaultNull = durationDefaultNull ?? Duration(days: 2, hours: 1, minutes: 20, seconds: 40, milliseconds: 100)',
          );
        },
      );
    });
  });

  group(
      'Given a class named DurationDefaultPersist with Duration fields having defaultPersistValue when generating code',
      () {
    ClassDeclaration? baseClass;
    ConstructorDeclaration? privateConstructor;

    setUpAll(() {
      var testClassName = 'DurationDefaultPersist';
      var testClassFileName = 'duration_default_persist';
      var expectedFilePath =
          path.join('lib', 'src', 'generated', '$testClassFileName.dart');

      var fields = [
        FieldDefinitionBuilder()
            .withName('durationDefaultPersist')
            .withTypeDefinition('Duration', true)
            .withDefaults(defaultPersistValue: '1d 2h 10min 30s 100ms')
            .build(),
      ];

      var models = [
        ClassDefinitionBuilder()
            .withClassName(testClassName)
            .withFileName(testClassFileName)
            .withFields(fields)
            .build()
      ];

      var codeMap = generator.generateSerializableModelsCode(
        models: models,
        config: config,
      );

      var compilationUnit =
          parseString(content: codeMap[expectedFilePath]!).unit;
      baseClass = CompilationUnitHelpers.tryFindClassDeclaration(
        compilationUnit,
        name: testClassName,
      );

      privateConstructor = CompilationUnitHelpers.tryFindConstructorDeclaration(
        baseClass!,
        name: '_',
      );
    });

    group('then the DurationDefaultPersist has a private constructor', () {
      test('defined', () {
        expect(privateConstructor, isNotNull);
      });

      test(
        'with the class vars as params',
        () {
          expect(
            privateConstructor?.parameters.toSource(),
            '({this.durationDefaultPersist})',
          );
        },
      );
    });
  });
}