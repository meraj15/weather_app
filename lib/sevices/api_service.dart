import 'dart:convert';
import 'dart:io'; // 👈 Needed for SocketException
import 'package:http/http.dart' as http;
import 'package:practice_waether_app/model/weather.dart';

class ApiService {
  Future<WeatherResponse> fetchWeather(String cityName) async {
    final String url =
        "https://api.openweathermap.org/data/2.5/weather?q=$cityName&appid=4a0909115c77f2ff8549441150de1ecf";

    try {
      final response = await http.get(Uri.parse(url));
      final responseBody = jsonDecode(response.body);

      if (response.statusCode == 200) {
        return WeatherResponse.fromJson(responseBody);
      } else if (response.statusCode == 401 || response.statusCode == 404) {
        throw Exception(responseBody['message']);
      } else {
        throw Exception("Something went wrong. Please try again.");
      }
    } on SocketException {
      throw Exception("No Internet connection.");
    } catch (e) {
      throw Exception(e.toString().replaceAll("Exception:", "").trim());
    }
  }
}
