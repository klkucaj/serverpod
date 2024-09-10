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
        'fromJson method correctly uses CustomClass.fromJson without casting to Map<String, dynamic>.',
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
            'The fromJson method does not correctly use CustomClass.fromJson without casting to Map<String, dynamic>.',
      );
    });
  });
}
