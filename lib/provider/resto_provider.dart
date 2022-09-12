import 'package:flutter/material.dart';
import '../api/api_service.dart';

enum ResultState { loading, noData, hasData, error }

class RestoProvider extends ChangeNotifier {
  final ApiService apiService;
  final String type;
  final String id;

  RestoProvider(
      {required this.apiService, required this.type, required this.id}) {
    if (type == 'list') {
      fetchRestoFull();
    } else if (type == 'detail') {
      fetchRestoDetail(id);
    }
  }

  late dynamic _resto;

  late ResultState _state;
  String _message = '';

  String get message => _message;
  dynamic get result => _resto;

  ResultState get state => _state;

  Future<dynamic> fetchRestoFull() async {
    try {
      _state = ResultState.loading;
      notifyListeners();
      final restaurantList = await apiService.restaurantList();
      if (restaurantList.restaurants.isEmpty) {
        _state = ResultState.noData;
        notifyListeners();
        return _message = 'Tidak ada data';
      } else {
        _state = ResultState.hasData;
        notifyListeners();
        return _resto = restaurantList;
      }
    } catch (e) {
      _state = ResultState.error;
      notifyListeners();
      return _message = 'Oops. Terjadi Kesalahan!';
    }
  }

  Future<dynamic> fetchRestoDetail(String id) async {
    try {
      _state = ResultState.loading;
      notifyListeners();
      final restaurantDetail = await apiService.restaurantDetail(id);
      _state = ResultState.hasData;
      notifyListeners();
      return _resto = restaurantDetail;
    } catch (e) {
      _state = ResultState.error;
      notifyListeners();
      return _message = 'Oops. Terjadi Kesalahan!';
    }
  }
}
