import 'package:analyzer/dart/analysis/utilities.dart';
import 'package:path/path.dart' as path;
import 'package:serverpod_cli/src/generator/dart/server_code_generator.dart';
import 'package:serverpod_cli/src/test_util/builders/class_definition_builder.dart';
import 'package:serverpod_cli/src/test_util/builders/generator_config_builder.dart';
import 'package:serverpod_cli/src/test_util/builders/serializable_entity_field_definition_builder.dart';
import 'package:serverpod_cli/src/test_util/builders/type_definition_builder.dart';
import 'package:serverpod_cli/src/test_util/compilation_unit_helpers.dart';
import 'package:test/test.dart';

const projectName = 'example_project';
final config = GeneratorConfigBuilder().withName(projectName).build();
const generator = DartServerCodeGenerator();

void main() {
  var testClassName = 'Example';
  var testClassFileName = 'example';
  var expectedFilePath =
      path.join('lib', 'src', 'generated', '$testClassFileName.dart');

  group('Given class $testClassName when generating code', () {
    var models = [
      ClassDefinitionBuilder()
          .withClassName(testClassName)
          .withFileName(testClassFileName)
          .withField(
            FieldDefinitionBuilder()
                .withName('customClassField')
                .withType(
                  TypeDefinitionBuilder()
                      .withClassName('CustomClass')
                      .withCustomClass(true)
                      .build(),
                )
                .build(),
          )
          .build()
    ];

    var codeMap = generator.generateSerializableModelsCode(
      models: models,
      config: config,
    );

    var compilationUnit = parseString(content: codeMap[expectedFilePath]!).unit;

    var maybeClassNamedExample = CompilationUnitHelpers.tryFindClassDeclaration(
      compilationUnit,
      name: testClassName,
    );

    test(
        'then fromJson method should pass data as dynamic to custom class fromJson',
        () {
      var fromJsonConstructor =
          CompilationUnitHelpers.tryFindConstructorDeclaration(
        maybeClassNamedExample!,
        name: 'fromJson',
      );

      var fromJsonCode = fromJsonConstructor!.toSource();

      expect(
        fromJsonCode.contains(
          "CustomClass.fromJson(jsonSerialization['customClassField'])",
        ),
        isTrue,
        reason:
            'The fromJson method should pass data as dynamic to CustomClass.fromJson but doesn\'t.',
      );
    });

    test(
      'then toJsonForProtocol method should correctly serialize customClassField by calling the appropriate toJson method',
      () {
        var toJsonForProtocolMethod =
            CompilationUnitHelpers.tryFindMethodDeclaration(
          maybeClassNamedExample!,
          name: 'toJsonForProtocol',
        );

        var toJsonForProtocolCode = toJsonForProtocolMethod!.toSource();

        var expectedCode =
            '@override Map<String, dynamic> toJsonForProtocol() {'
            'return {'
            "'customClassField' : customClassField is _i1.ProtocolSerialization "
            '? (customClassField as _i1.ProtocolSerialization).toJsonForProtocol() : customClassField.toJson()'
            '};'
            '}';

        expect(
          toJsonForProtocolCode,
          equals(expectedCode),
          reason:
              'The toJsonForProtocol method should correctly serialize customClassField '
              'by checking if it implements ProtocolSerialization and calling the '
              'appropriate toJsonForProtocol or toJson method.',
        );
      },
    );

    test(
      'then toJson method should not call toJsonForProtocol method',
      () {
        var toJsonMethod = CompilationUnitHelpers.tryFindMethodDeclaration(
          maybeClassNamedExample!,
          name: 'toJson',
        );

        var toJsonCode = toJsonMethod!.toSource();

        expect(
          toJsonCode.contains('toJsonForProtocol'),
          isFalse,
          reason: 'The toJson method should not call toJsonForProtocol method.',
        );
      },
    );
  });
}
