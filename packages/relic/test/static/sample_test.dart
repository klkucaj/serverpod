import 'dart:io';

import 'package:path/path.dart' as p;
import 'package:relic/relic.dart';
import 'package:relic/src/method/method.dart';
import 'package:test/test.dart';

import 'test_util.dart';

void main() {
  group('/index.html', () {
    test('body is correct', () async {
      await _testFileContents('index.html');
    });

    test('mimeType is text/html', () async {
      final response = await _requestFile('index.html');
      expect(response.mimeType, 'text/html');
    });

    group('/favicon.ico', () {
      test('body is correct', () async {
        await _testFileContents('favicon.ico');
      });

      test('mimeType is text/html', () async {
        final response = await _requestFile('favicon.ico');
        expect(response.mimeType, 'image/x-icon');
      });
    });
  });

  group('/dart.png', () {
    test('body is correct', () async {
      await _testFileContents('dart.png');
    });

    test('mimeType is image/png', () async {
      final response = await _requestFile('dart.png');
      expect(response.mimeType, 'image/png');
    });
  });
}

Future<Response> _requestFile(String filename) {
  final uri = Uri.parse('http://localhost/$filename');

  return _request(Request(Method.get, uri));
}

Future<void> _testFileContents(String filename) async {
  final filePath = p.join(_samplePath, filename);
  final file = File(filePath);
  final fileContents = file.readAsBytesSync();
  final fileStat = file.statSync();

  final response = await _requestFile(filename);
  expect(response.body.contentLength, fileStat.size);
  expect(
    response.headers.lastModified,
    atSameTimeToSecond(fileStat.modified.toUtc()),
  );
  await _expectCompletesWithBytes(response, fileContents);
}

Future<void> _expectCompletesWithBytes(
    Response response, List<int> expectedBytes) async {
  final bytes = await response.read().toList();
  final flatBytes = bytes.expand((e) => e);
  expect(flatBytes, orderedEquals(expectedBytes));
}

Future<Response> _request(Request request) async {
  final handler = createStaticHandler(_samplePath);
  return await handler(request);
}

String get _samplePath {
  final sampleDir = p.join(p.current, 'example', 'files');
  assert(FileSystemEntity.isDirectorySync(sampleDir));
  return sampleDir;
}
