part of 'allegro_api.dart';

class AllegroOfferRepository extends AllegroApi {
  final String accessToken;

  AllegroOfferRepository({required this.accessToken});

  final String _offers = '/sale/offers';

  Future<List<AllegroOffer>> getSellersOffers() async {
    final auth = 'Bearer $accessToken';

    final headers = {
      'Authorization': auth,
      'Content-Type': 'application/vnd.allegro.public.v1+json',
      'Accept': 'application/vnd.allegro.public.v1+json'
    };

    final query = {
      'publication.status': 'ACTIVE',
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
}
