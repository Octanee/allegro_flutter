part of 'allegro_api.dart';

class AllegroOrderRepository extends AllegroApi {
  final String accessToken;

  AllegroOrderRepository({required this.accessToken});

  final String _orders = '/order/events';

  Future<List<AllegroOrder>> getOrders() async {
    final auth = 'Bearer $accessToken';

    final headers = {
      'Authorization': auth,
      'Content-Type': 'application/vnd.allegro.public.v1+json',
      'Accept': 'application/vnd.allegro.public.v1+json'
    };

    final query = {
      'type': 'READY_FOR_PROCESSING',
    };

    final uri = getUri(endPoint: _orders, params: query);

    final response = await http.get(
      uri,
      headers: headers,
    );

    if (response.statusCode != 200) {
      throw AllegroApiException(
        message: response.body,
        code: response.statusCode,
      );
    } else {
      final map = jsonDecode(response.body) as Map<String, dynamic>;
      final list = map['events'] as List;
      final values = list.map((order) => AllegroOrder.fromMap(order)).toList();
      return values;
    }
  }
}
