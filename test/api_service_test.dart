import 'package:carimangan/data/api_service/api_service.dart';
import 'package:carimangan/data/model/restaurant.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'api_service_test.mocks.dart';

@GenerateMocks([http.Client])
void main() {
  group('Fetch List Restaurant', () {
    test('returns an Restaurant if the http call completes successfully',
        () async {
      final client = MockClient();

      when(client.get(Uri.parse(ApiService.baseUrl + ApiService.list)))
          .thenAnswer((_) async => http.Response('{"restaurants":[]}', 200));
      expect(
          await ApiService(client).listRestaurant(), isA<RestaurantResult>());
    });
  });
}
