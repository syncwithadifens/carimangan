import 'package:carimangan/data/model/restaurant.dart';

class SearchResult {
  SearchResult({
    required this.restaurants,
  });

  List<Restaurant> restaurants;

  factory SearchResult.fromJson(Map<String, dynamic> json) => SearchResult(
        restaurants: List<Restaurant>.from(
            json["restaurants"].map((x) => Restaurant.fromJson(x))),
      );
}
