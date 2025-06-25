import 'package:flutter/material.dart';
import 'package:practice_waether_app/model/weather.dart';
import 'package:practice_waether_app/sevices/api_service.dart';


class WeatherViewModel extends ChangeNotifier {
  final ApiService apiService;

  WeatherViewModel({required this.apiService});

  WeatherResponse? _responseData;
  bool _isLoading = false;
  String? _errorMessage;

  WeatherResponse? get responseData => _responseData;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  Future<void> fetchResponse(String cityName) async {
    _isLoading = true;
    _errorMessage = null;
    _responseData = null;
    notifyListeners();

    try {
      await Future.delayed(const Duration(seconds: 2));
      _responseData = await apiService.fetchWeather(cityName);
    } catch (e) {
      _errorMessage = e.toString().replaceFirst("Exception: ", "");
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void clearError() {
  _errorMessage = null;
  notifyListeners();
}
}