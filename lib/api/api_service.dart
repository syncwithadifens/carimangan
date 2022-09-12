import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:carimangan/models/restaurant.dart';

class ApiService {
  static const String _baseUrl = "https://restaurant-api.dicoding.dev/";
  static const String imgUrl =
      'https://restaurant-api.dicoding.dev/images/medium/';

  Future<RestoList> restaurantList() async {
    final response = await http.get(
      Uri.parse("${_baseUrl}list"),
    );
    if (response.statusCode == 200) {
      return RestoList.fromJson(
        json.decode(response.body),
      );
    } else {
      throw Exception('Failed to load the restaurant list');
    }
  }

  Future<RestoDetail> restaurantDetail(String id) async {
    final response = await http.get(
      Uri.parse("${_baseUrl}detail/$id"),
    );
    if (response.statusCode == 200) {
      return RestoDetail.fromJson(
        json.decode(response.body),
      );
    } else {
      throw Exception('Failed to load the restaurant details.');
    }
  }

  Future<RestoSearch> searchRestaurant(String query) async {
    final response = await http.get(
      Uri.parse('${_baseUrl}search?q=$query'),
    );
    if (response.statusCode == 200) {
      return RestoSearch.fromJson(
        json.decode(response.body),
      );
    } else {
      throw Exception('Failed to Search Restaurant');
    }
  }
}
