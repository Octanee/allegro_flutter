part of 'allegro_api.dart';

class AllegroOfferRepository extends AllegroApi {
  final String accessToken;

  AllegroOfferRepository({required this.accessToken});

  final String _offers = '/sale/offers';

  String _productOffer({required String id}) => '/sale/product-offers/$id';

  String _quantityChange({required String id}) =>
      '/sale/offer-quantity-change-commands/$id';

  String _quantityChangeTasks({required String id}) =>
      '/sale/offer-quantity-change-commands/$id/tasks';

  String _publicationChange({required String id}) =>
      '/sale/offer-publication-commands/$id';

  Future<List<AllegroOffer>> getSellersOffers() async {
    final auth = 'Bearer $accessToken';

    final headers = {
      'Authorization': auth,
      'Content-Type': 'application/vnd.allegro.public.v1+json',
      'Accept': 'application/vnd.allegro.public.v1+json'
    };

    final query = {
      'publication.status': [
        'ACTIVE',
        'ENDED',
      ],
    };

    final uri = getUri(endPoint: _offers, params: query);

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
      final list = map['offers'] as List;
      final values = list.map((offer) => AllegroOffer.fromMap(offer)).toList();
      return values;
    }
  }

  Future<AllegroOffer> addOffer({required AllegroOffer offer}) async {
    final auth = 'Bearer $accessToken';

    final headers = {
      'Authorization': auth,
      'Content-Type': 'application/vnd.allegro.public.v1+json',
      'Accept': 'application/vnd.allegro.public.v1+json'
    };

    final data = jsonEncode(offer.toAllegro());

    final uri = getUri(endPoint: _offers);

    final response = await http.post(
      uri,
      headers: headers,
      body: data,
    );

    if (response.statusCode != 200) {
      throw AllegroApiException(
        message: response.body,
        code: response.statusCode,
      );
    } else {
      final value = AllegroOffer.fromJson(response.body);
      return value;
    }
  }

  Future<void> updateOffer({
    required String id,
    required Map<String, dynamic> data,
  }) async {
    final auth = 'Bearer $accessToken';

    final headers = {
      'Authorization': auth,
      'Content-Type': 'application/vnd.allegro.public.v1+json',
      'Accept': 'application/vnd.allegro.public.v1+json'
    };

    final body = jsonEncode(data);

    final uri = getUri(endPoint: _productOffer(id: id));

    final response = await http.patch(
      uri,
      headers: headers,
      body: body,
    );

    if (response.statusCode != 200) {
      throw AllegroApiException(
        message: response.body,
        code: response.statusCode,
      );
    }
  }

  Future<void> endOffer({required String id}) async {
    final auth = 'Bearer $accessToken';

    final headers = {
      'Authorization': auth,
      'Content-Type': 'application/vnd.allegro.public.v1+json',
      'Accept': 'application/vnd.allegro.public.v1+json'
    };

    final data = {
      'publication': {
        'action': 'END',
      },
      'offerCriteria': [
        {
          'type': 'CONTAINS_OFFERS',
          'offers': [
            {
              'id': id,
            },
          ],
        },
      ],
    };

    final body = jsonEncode(data);

    const uuid = Uuid();
    final uri = getUri(endPoint: _publicationChange(id: uuid.v1()));

    final response = await http.put(
      uri,
      headers: headers,
      body: body,
    );

    if (response.statusCode != 200 && response.statusCode != 201) {
      throw AllegroApiException(
        message: response.body,
        code: response.statusCode,
      );
    }
  }

  Future<void> sellAll({required String id}) async {
    final auth = 'Bearer $accessToken';

    final headers = {
      'Authorization': auth,
      'Content-Type': 'application/vnd.allegro.public.v1+json',
      'Accept': 'application/vnd.allegro.public.v1+json'
    };

    final data = {
      'stock': {
        'available': 0,
      }
    };

    final body = jsonEncode(data);

    final uri = getUri(endPoint: _productOffer(id: id));

    final response = await http.patch(
      uri,
      headers: headers,
      body: body,
    );

    if (response.statusCode != 200 && response.statusCode != 201) {
      throw AllegroApiException(
        message: response.body,
        code: response.statusCode,
      );
    }
  }

  Future<String?> updateQuantity({
    required List<String> id,
    required int value,
  }) async {
    log('AllegroOfferRepository => updateQuantity {id: $id, value: $value }');
    final auth = 'Bearer $accessToken';

    final headers = {
      'Authorization': auth,
      'Content-Type': 'application/vnd.allegro.public.v1+json',
      'Accept': 'application/vnd.allegro.public.v1+json'
    };

    final data = {
      'modification': {
        'changeType': 'GAIN',
        'value': -value,
      },
      'offerCriteria': [
        {
          'type': 'CONTAINS_OFFERS',
          'offers': List.generate(
            id.length,
            (index) => {
              'id': id[index],
            },
          ),
        },
      ],
    };

    final body = jsonEncode(data);

    const uuid = Uuid();
    final uri = getUri(endPoint: _quantityChange(id: uuid.v1()));

    final response = await http.put(
      uri,
      headers: headers,
      body: body,
    );

    if (response.statusCode != 200 && response.statusCode != 201) {
      throw AllegroApiException(
        message: response.body,
        code: response.statusCode,
      );
    }

    final responseBody = jsonDecode(response.body);

    final success = await _updateQuantitySuccess(id: responseBody['id']);

    if (success) {
      log('AllegroOfferRepository => updateQuantity {id: $id, value: $value } => Success');

      return null;
    }

    return await _getFailedId(id: responseBody['id']);
  }

  Future<String> _getFailedId({required String id}) async {
    log('AllegroOfferRepository => _getFailedId {id: $id } => Failed');

    final auth = 'Bearer $accessToken';

    final headers = {
      'Authorization': auth,
      'Content-Type': 'application/vnd.allegro.public.v1+json',
      'Accept': 'application/vnd.allegro.public.v1+json'
    };

    final uri = getUri(endPoint: _quantityChangeTasks(id: id));

    final response = await http.get(
      uri,
      headers: headers,
    );

    if (response.statusCode != 200) {
      throw AllegroApiException(
        message: response.body,
        code: response.statusCode,
      );
    }

    final responseBody = jsonDecode(response.body);

    log('AllegroOfferRepository => _getFailedId {responseBody: $responseBody');

    final tasks = responseBody['tasks'] as List;

    log('AllegroOfferRepository => _getFailedId {tasks: $tasks');

    final failed =
        tasks.firstWhere((element) => element['status'] != 'SUCCESS');

    log('AllegroOfferRepository => _getFailedId {failed: $failed');

    return failed['offer']['id'];
  }

  Future<bool> _updateQuantitySuccess({required String id}) async {
    log('AllegroOfferRepository => _updateQuantitySuccess {id: $id }');
    final auth = 'Bearer $accessToken';

    final headers = {
      'Authorization': auth,
      'Content-Type': 'application/vnd.allegro.public.v1+json',
      'Accept': 'application/vnd.allegro.public.v1+json'
    };

    final uri = getUri(endPoint: _quantityChange(id: id));

    final response = await http.get(
      uri,
      headers: headers,
    );

    if (response.statusCode != 200) {
      throw AllegroApiException(
        message: response.body,
        code: response.statusCode,
      );
    }

    final data = jsonDecode(response.body);

    log('AllegroOfferRepository => _updateQuantitySuccess {id: $id } => data: $data');

    final total = data['taskCount']['total'];
    final success = data['taskCount']['success'];
    final failed = data['taskCount']['failed'];

    if (failed != 0) {
      return false;
    }

    if (total != 0 && total == success) {
      return true;
    }

    await Future.delayed(const Duration(seconds: 1));
    return await _updateQuantitySuccess(id: id);
  }
}
