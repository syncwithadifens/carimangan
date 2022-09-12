import 'package:flutter/material.dart';
import 'package:carimangan/data/model/search_result.dart';
import '../data/api_service/api_service.dart';
import '../utils/result_state.dart';

class SearchProvider extends ChangeNotifier {
  final ApiService apiService;

  SearchProvider({required this.apiService}) {
    fetchQueryRestaurant(query);
  }

  SearchResult? _restaurantList;
  ResultState? _state;
  String _message = '';
  String _query = '';

  String get message => _message;
  String get query => _query;
  SearchResult? get result => _restaurantList;
  ResultState? get state => _state;

  Future<dynamic> fetchQueryRestaurant(String query) async {
    try {
      if (query.isNotEmpty) {
        _state = ResultState.loading;
        _query = query;
        notifyListeners();
        final restaurantList = await apiService.searchResult(query);
        if (restaurantList.restaurants.isEmpty) {
          _state = ResultState.noData;
          notifyListeners();
          return _message = 'Tempat yang anda cari tidak ada di data kami';
        } else {
          _state = ResultState.hasData;
          notifyListeners();
          return _restaurantList = restaurantList;
        }
      }
    } catch (e) {
      _state = ResultState.error;
      notifyListeners();
      return _message = 'Oops, Terjadi Kesalahan';
    }
  }
}
