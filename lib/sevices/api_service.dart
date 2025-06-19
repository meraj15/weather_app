import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:practice_waether_app/constant/app_string.dart';
import 'package:practice_waether_app/model/weather.dart';

class ApiService {
  Future<WeatherResponse> fetchWeather(String cityName) async {
    final url =
        '${Constants.baseUrl}${Constants.weatherEndpoint}?q=$cityName&appid=${Constants.apiKey}';

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
