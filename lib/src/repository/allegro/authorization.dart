part of 'allegro_api.dart';

class AllegroAuthorizationRepository extends AllegroApi {
  final String _authDevice = '/auth/oauth/device';
  final String _authToken = '/auth/oauth/token';

  Future<Map<String, dynamic>> appAuthorization({
    required String clientId,
    required String clientSecret,
  }) async {
    final basicAuth =
        'Basic ${base64Encode(utf8.encode('$clientId:$clientSecret'))}';

    final headers = {
      'Authorization': basicAuth,
      'Content-Type': 'application/x-www-form-urlencoded'
    };

    final body = 'client_id=$clientId';

    final uri = getUri(endPoint: _authDevice, isApi: false);

    final response = await http.post(
      uri,
      headers: headers,
      body: body,
    );

    if (response.statusCode != 200) {
      throw AllegroApiException(
        message: response.body,
        code: response.statusCode,
      );
    } else {
      printJson(response.body);
      return jsonDecode(response.body);
    }
  }

  Future<Map<String, dynamic>?> getAuthToken({
    required String clientId,
    required String clientSecret,
    required String deviceCode,
  }) async {
    final basicAuth =
        'Basic ${base64Encode(utf8.encode('$clientId:$clientSecret'))}';

    final headers = {
      'Authorization': basicAuth,
      'Content-Type': 'application/x-www-form-urlencoded'
    };

    final params = {
      'grant_type': 'urn:ietf:params:oauth:grant-type:device_code',
      'device_code': deviceCode,
    };

    final uri = getUri(endPoint: _authToken, isApi: false, params: params);

    final response = await http.post(
      uri,
      headers: headers,
    );

    if (response.statusCode != 200) {
      if (response.statusCode == 400) {
        return null;
      }
      throw AllegroApiException(
        message: response.body,
        code: response.statusCode,
      );
    } else {
      return jsonDecode(response.body);
    }
  }

  Future<Map<String, dynamic>> refreshToken({
    required String clientId,
    required String clientSecret,
    required String refreshToken,
  }) async {
    final basicAuth =
        'Basic ${base64Encode(utf8.encode('$clientId:$clientSecret'))}';
    final headers = {
      'Authorization': basicAuth,
      'Content-Type': 'application/x-www-form-urlencoded'
    };
    final params = {
      'grant_type': 'refresh_token',
      'refresh_token': refreshToken,
    };

    final uri = getUri(endPoint: _authToken, isApi: false, params: params);

    final response = await http.post(
      uri,
      headers: headers,
    );

    if (response.statusCode != 200) {
      throw AllegroApiException(
        message: response.body,
        code: response.statusCode,
      );
    } else {
      return jsonDecode(response.body);
    }
  }
}
