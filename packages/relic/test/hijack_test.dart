import 'dart:async';

import 'package:relic/relic.dart';
import 'package:relic/src/method/method.dart';
import 'package:stream_channel/stream_channel.dart';
import 'package:test/test.dart';

import 'test_util.dart';

void main() {
  test('hijacking a non-hijackable request throws a StateError', () {
    expect(() => Request(Method.get, localhostUri).hijack((_) {}),
        throwsStateError);
  });

  test(
      'hijacking a hijackable request throws a HijackException and calls '
      'onHijack', () {
    var request =
        Request(Method.get, localhostUri, onHijack: expectAsync1((callback) {
      var streamController = StreamController<List<int>>();
      streamController.add([1, 2, 3]);
      streamController.close();

      var sinkController = StreamController<List<int>>();
      expect(sinkController.stream.first, completion(equals([4, 5, 6])));

      callback(StreamChannel(streamController.stream, sinkController));
    }));

    expect(
        () => request.hijack(expectAsync1((channel) {
              expect(channel.stream.first, completion(equals([1, 2, 3])));
              channel.sink.add([4, 5, 6]);
              channel.sink.close();
            })),
        throwsHijackException);
  });

  test('hijacking a hijackable request twice throws a StateError', () {
    // Assert that the [onHijack] callback is only called once.
    var request = Request(Method.get, localhostUri,
        onHijack: expectAsync1((_) {}, count: 1));

    expect(() => request.hijack((_) {}), throwsHijackException);

    expect(() => request.hijack((_) {}), throwsStateError);
  });
}
