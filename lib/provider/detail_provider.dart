import 'package:flutter/material.dart';
import '../data/api_service/api_service.dart';
import '../data/model/detail_restaurant.dart';
import '../utils/result_state.dart';

class DetailProvider extends ChangeNotifier {
  final ApiService apiService;
  final String resto;

  DetailProvider({required this.apiService, required this.resto}) {
    _fetchDetailRestaurant();
  }

  late DetailResult _detailResult;
  late ResultState _state;
  String _message = '';

  DetailResult get detailResult => _detailResult;
  ResultState get state => _state;
  String get message => _message;

  Future<dynamic> _fetchDetailRestaurant() async {
    try {
      _state = ResultState.loading;
      notifyListeners();
      final restaurant = await apiService.detailRestaurant(resto);
      if (restaurant.restaurants.id.isEmpty) {
        _state = ResultState.noData;
        notifyListeners();
        return _message = 'Tidak ada data';
      } else {
        _state = ResultState.hasData;
        notifyListeners();
        return _detailResult = restaurant;
      }
    } catch (e) {
      _state = ResultState.error;
      notifyListeners();
      return _message = 'Oops, Terjadi Kesalahan';
    }
  }
}
