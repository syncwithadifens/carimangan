import 'package:carimangan/models/restaurant.dart';
import 'package:flutter/material.dart';
import '../api/api_service.dart';

enum SearchState { loading, noData, hasData, error, noQueri }

class SearchRestoProvider extends ChangeNotifier {
  final ApiService apiService;

  SearchRestoProvider({required this.apiService}) {
    fetcSearchResto();
  }

  late RestoSearch _searchResult;
  late SearchState _state;
  String _message = '';
  String query = '';

  String get message => _message;
  RestoSearch get result => _searchResult;
  SearchState get state => _state;

  Future<dynamic> fetcSearchResto() async {
    if (query != "") {
      try {
        _state = SearchState.loading;
        final search = await apiService.searchRestaurant(query);
        if (search.restaurants.isEmpty) {
          _state = SearchState.noData;
          notifyListeners();
          return _message = 'Tempat makan yang kamu cari tidak ditemukan';
        } else {
          _state = SearchState.hasData;
          notifyListeners();
          return _searchResult = search;
        }
      } catch (e) {
        _state = SearchState.error;
        notifyListeners();
        return _message = 'Whoops. Terjadi Kesalahan!';
      }
    } else {
      _state = SearchState.noQueri;
      notifyListeners();
      return _message = 'No queri';
    }
  }

  void addQueri(String query) {
    this.query = query;
    fetcSearchResto();
    notifyListeners();
  }
}
