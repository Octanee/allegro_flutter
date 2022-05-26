import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;

import '../exceptions/allegro_api/allegro_api.dart';
import '../utils/json_decoder.dart';
import '../models/allegro_api_environment.dart';

class AllegroApiRepository {
  final AllegroApiEnvironment environment;

  final String _authDevice = '/auth/oauth/device';
  final String _authToken = '/auth/oauth/token';

  AllegroApiRepository({this.environment = AllegroApiEnvironment.sandbox});

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

    final uri = _getUri(endPoint: _authDevice, isApi: false);
    log(uri.toString());
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

    final uri = _getUri(endPoint: _authToken, isApi: false, params: params);
    log(uri.toString());
    final response = await http.post(
      uri,
      headers: headers,
    );

    printJson(response.body);
    
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

  Uri _getUri({
    required String endPoint,
    bool isApi = true,
    Map<String, dynamic>? params,
  }) {
    String? query;
    if (params != null) {
      query = params.entries.map((e) => '${e.key}=${e.value}').join('&');
    }

    final path = StringBuffer('https://');
    if (isApi) path.write('api.');
    path.write('${environment.path}$endPoint');
    if (query != null) path.write('?$query');

    return Uri.parse(path.toString());
  }
}
