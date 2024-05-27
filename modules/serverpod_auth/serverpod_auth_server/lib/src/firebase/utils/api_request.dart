import 'package:http/http.dart';

import '../app.dart';

/// [BaseClient] wrapper to make all api requests authorized
class AuthorizedHttpClient extends BaseClient {
  final App app;

  final Duration? timeout;

  final Client client = httpClientFactory();

  /// Creates a new [AuthorizedHttpClient] object
  AuthorizedHttpClient(this.app, [this.timeout]);

  @override
  Future<StreamedResponse> send(BaseRequest request) async {
    var accessTokenObj = await app.internals.getToken();

    request.headers['Authorization'] = 'Bearer ${accessTokenObj.accessToken}';

    var r = client.send(request);
    if (timeout != null) r = r.timeout(timeout!);
    return r;
  }

  static Client Function() httpClientFactory = () => Client();
}
