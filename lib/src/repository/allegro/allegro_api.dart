import 'dart:convert';
import 'package:http/http.dart' as http;

import '../../exceptions/allegro_api/allegro_api.dart';
import '../../models/models.dart';
import '../../utils/json_decoder.dart';

part 'authorization.dart';
part 'offer.dart';
part 'order.dart';

class AllegroApi {
  final AllegroApiEnvironment environment;

  const AllegroApi({
    this.environment = AllegroApiEnvironment.sandbox,
  });

  Uri getUri({
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
