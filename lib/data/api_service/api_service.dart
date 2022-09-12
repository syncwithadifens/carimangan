import 'package:carimangan/data/model/search_result.dart';
import '../model/detail_restaurant.dart';
import '../model/restaurant.dart';
import 'package:http/http.dart' show Client;
import 'dart:convert';

class ApiService {
  static const String baseUrl = 'https://restaurant-api.dicoding.dev/';
  static const String list = 'list';
  static const String _detail = 'detail/';
  static const String _search = 'search?q=';
  static const String _throw = 'Failed load data';

  final Client client;

  ApiService(this.client);

  Future<RestaurantResult> listRestaurant() async {
    final response = await client.get(Uri.parse(baseUrl + list));
    if (response.statusCode == 200) {
      return RestaurantResult.fromJson(json.decode(response.body));
    } else {
      throw Exception(_throw);
    }
  }

  Future<DetailResult> detailRestaurant(String id) async {
    final response = await client.get(Uri.parse(baseUrl + _detail + id));
    if (response.statusCode == 200) {
      return DetailResult.fromJson(json.decode(response.body));
    } else {
      throw Exception(_throw);
    }
  }

  Future<SearchResult> searchResult(String query) async {
    final response = await client.get(Uri.parse(baseUrl + _search + query));
    if (response.statusCode == 200) {
      return SearchResult.fromJson(json.decode(response.body));
    } else {
      throw Exception(_throw);
    }
  }
}
