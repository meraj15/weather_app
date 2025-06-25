import 'package:flutter/material.dart';
import 'package:practice_waether_app/constant/colors.dart';
import 'package:practice_waether_app/view/weather_detail_screen.dart';
import 'package:practice_waether_app/view_model/weather_view_model.dart';
import 'package:practice_waether_app/widgets/app_button.dart';
import 'package:shimmer/shimmer.dart';

class WeatherCard extends StatelessWidget {
  final WeatherViewModel vm;
  const WeatherCard({super.key, required this.vm});

  @override
  Widget build(BuildContext context) {
    final data = vm.responseData;

    if (vm.isLoading) {
      // 🔥 SHIMMER with same size placeholders
      return Card(
        color: AppColors.card,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
          child: Shimmer.fromColors(
            baseColor: Colors.grey.shade300,
            highlightColor: Colors.grey.shade100,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  height: 30,
                  width: 150,
                  color: Colors.white,
                ),
                const SizedBox(height: 10),
                Container(
                  height: 30,
                  width: 100,
                  color: Colors.white,
                ),
                const SizedBox(height: 10),
                Container(
                  height: 20,
                  width: 120,
                  color: Colors.white,
                ),
                const SizedBox(height: 15),
                Container(
                  height: 37,
                  width: 110,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }

    if (data == null) {
      return const Text("No data found");
    }

    return Card(
      color: AppColors.card,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              data.cityName,
              style: TextStyle(
                color: AppColors.primary,
                fontSize: 25,
                fontWeight: FontWeight.w500,
              ),
            ),
            Text(
              "${data.mainWeather.temp.toStringAsFixed(1)} °C",
              style: const TextStyle(color: Colors.black, fontSize: 25),
            ),
            const SizedBox(height: 5),
            Text(
              data.weatherList[0].description,
              style: TextStyle(
                color: AppColors.textSecondary,
                fontSize: 15,
              ),
            ),
            const SizedBox(height: 15),
            AppButton(
              height: 37,
              width: 110,
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) =>
                        DetailedWeatherScreen(weatherResponse: data),
                  ),
                );
              },
              title: "View Details",
            ),
          ],
        ),
      ),
    );
  }
}
