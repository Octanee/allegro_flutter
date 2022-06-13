import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:uuid/uuid.dart';

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
      query = params.entries.map((e) {
        if (e.value is List) {
          final list = e.value as List;
          final temp = StringBuffer('');
          for (var element in list) {
            temp.write('${e.key}=$element');
            if (list.last != element) {
              temp.write('&');
            }
          }
          return temp;
        }
        return '${e.key}=${e.value}';
      }).join('&');
    }

    final path = StringBuffer('https://');
    if (isApi) path.write('api.');
    path.write('${environment.path}$endPoint');
    if (query != null) path.write('?$query');

    log('AllegroApi => getUri { path: $path }');

    return Uri.parse(path.toString());
  }
}
