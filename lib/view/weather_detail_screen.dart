import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:country_picker/country_picker.dart';
import 'package:practice_waether_app/constant/colors.dart';
import 'package:practice_waether_app/model/weather.dart';
import '../widgets/weather_detail_card.dart';

class DetailedWeatherScreen extends StatelessWidget {
  final WeatherResponse weatherResponse;

  const DetailedWeatherScreen({super.key, required this.weatherResponse});

  String _formatUnixTime(int unixTime) {
    final date = DateTime.fromMillisecondsSinceEpoch(unixTime * 1000);
    return DateFormat('hh:mm a').format(date);
  }

  @override
  Widget build(BuildContext context) {
    final country = Country.tryParse(weatherResponse.weatherSys.country);

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Text('${weatherResponse.cityName} Details'),
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Weather Overview',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
                color: AppColors.primary,
              ),
            ),
            const SizedBox(height: 16.0),
            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 12.0,
                mainAxisSpacing: 12.0,
                childAspectRatio: 1.5,
                children: [
                  WeatherDetailCard(
                    title: 'Temperature',
                    value:
                        '${weatherResponse.mainWeather.temp.toStringAsFixed(1)}°C',
                    leadingIcon: const Icon(
                      Icons.thermostat,
                      color: AppColors.accent,
                    ),
                  ),
                  WeatherDetailCard(
                    title: 'Feels Like',
                    value:
                        '${weatherResponse.mainWeather.feelsLike.toStringAsFixed(1)}°C',
                    leadingIcon: const Icon(
                      Icons.thermostat_outlined,
                      color: AppColors.accent,
                    ),
                  ),
                  WeatherDetailCard(
                    title: 'Min Temp',
                    value:
                        '${weatherResponse.mainWeather.tempMin.toStringAsFixed(1)}°C',
                    leadingIcon: const Icon(
                      Icons.arrow_downward,
                      color: AppColors.accent,
                    ),
                  ),
                  WeatherDetailCard(
                    title: 'Max Temp',
                    value:
                        '${weatherResponse.mainWeather.tempMax.toStringAsFixed(1)}°C',
                    leadingIcon: const Icon(
                      Icons.arrow_upward,
                      color: AppColors.accent,
                    ),
                  ),
                  WeatherDetailCard(
                    title: 'Humidity',
                    value: '${weatherResponse.mainWeather.humidity}%',
                    leadingIcon: const Icon(
                      Icons.water_drop,
                      color: AppColors.accent,
                    ),
                  ),
                  WeatherDetailCard(
                    title: 'Pressure',
                    value: '${weatherResponse.mainWeather.pressure} hPa',
                    leadingIcon: const Icon(
                      Icons.compress,
                      color: AppColors.accent,
                    ),
                  ),
                  WeatherDetailCard(
                    title: 'Visibility',
                    value: '${weatherResponse.visibility / 1000} km',
                    leadingIcon: const Icon(
                      Icons.visibility,
                      color: AppColors.accent,
                    ),
                  ),
                  WeatherDetailCard(
                    title: 'Wind Speed',
                    value: '${weatherResponse.weatherWind.speed} m/s',
                    leadingIcon: const Icon(Icons.air, color: AppColors.accent),
                  ),
                  WeatherDetailCard(
                    title: 'Wind Direction',
                    value: '${weatherResponse.weatherWind.deg}°',
                    leadingIcon: const Icon(
                      Icons.navigation,
                      color: AppColors.accent,
                    ),
                  ),
                  WeatherDetailCard(
                    title: 'Wind Gust',
                    value: '${weatherResponse.weatherWind.gust} m/s',
                    leadingIcon: const Icon(
                      Icons.wind_power,
                      color: AppColors.accent,
                    ),
                  ),
                  WeatherDetailCard(
                    title: 'Cloudiness',
                    value: '${weatherResponse.weatherCloud.all}%',
                    leadingIcon: const Icon(
                      Icons.cloud,
                      color: AppColors.accent,
                    ),
                  ),
                  WeatherDetailCard(
                    title: 'Sunrise',
                    value: _formatUnixTime(weatherResponse.weatherSys.sunrise),
                    leadingIcon: const Icon(
                      Icons.wb_sunny,
                      color: AppColors.accent,
                    ),
                  ),
                  WeatherDetailCard(
                    title: 'Sunset',
                    value: _formatUnixTime(weatherResponse.weatherSys.sunset),
                    leadingIcon: const Icon(
                      Icons.nights_stay,
                      color: AppColors.accent,
                    ),
                  ),
                  WeatherDetailCard(
                    title: 'Coordinates',
                    value:
                        '${weatherResponse.weatherCoord.lat},\n${weatherResponse.weatherCoord.lon}',
                    leadingIcon: const Icon(
                      Icons.location_on,
                      color: AppColors.accent,
                    ),
                  ),
                  WeatherDetailCard(
                    title: 'Country',
                    value: country?.name ?? weatherResponse.weatherSys.country,
                    leadingIcon: Text(
                      country?.flagEmoji ?? '',
                      style: const TextStyle(fontSize: 20),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
