import 'package:flutter/material.dart';
import 'package:practice_waether_app/constant/colors.dart';
import 'package:practice_waether_app/view/weather_detail_screen.dart';
import 'package:practice_waether_app/view_model/weather_view_model.dart';
import 'package:practice_waether_app/widgets/app_button.dart';
import 'package:provider/provider.dart';

class WeatherApp extends StatefulWidget {
  const WeatherApp({super.key});

  @override
  State<WeatherApp> createState() => _WeatherAppState();
}

class _WeatherAppState extends State<WeatherApp> {
  String cityName = "Mumbai";
  final userSearch = TextEditingController();

  @override
  void initState() {
    super.initState();
    context.read<WeatherViewModel>().fetchResponse(cityName);
  }

  @override
  Widget build(BuildContext context) {
    final weatherViewModel = Provider.of<WeatherViewModel>(context);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (weatherViewModel.errorMessage != null) {
        showErrorDialog(context, weatherViewModel.errorMessage!);
        weatherViewModel.clearError();
      }
    });

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text(
          "Weather App",
          style: TextStyle(color: AppColors.card),
        ),
        backgroundColor: AppColors.primary,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: userSearch,
              onSubmitted: (value) {
                if (value.isNotEmpty) {
                  weatherViewModel.fetchResponse(value);
                  userSearch.clear();
                }
              },
              textInputAction: TextInputAction.done,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                suffixIcon: IconButton(
                  onPressed: () {
                    if (userSearch.text.isNotEmpty) {
                      weatherViewModel.fetchResponse(userSearch.text);
                      userSearch.clear();
                    }
                  },
                  icon: Icon(Icons.search),
                ),
                labelText: "Enter City",
              ),
            ),
          ),
          const SizedBox(height: 15),

          weatherViewModel.isLoading
              ? const CircularProgressIndicator()
              : buildWeatherCard(weatherViewModel),
        ],
      ),
    );
  }

  Widget buildWeatherCard(WeatherViewModel vm) {
    final data = vm.responseData;

    return data == null
        ? Text(
            Provider.of<WeatherViewModel>(context).errorMessage ??
                "no data found",
          )
        : Card(
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
                    style: TextStyle(color: Colors.black, fontSize: 25),
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

  void showErrorDialog(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text("City Not Found "),
        content: Text(message),
        actions: [
          AppButton(
            height: 33,
            width: 65,
            onTap: () {
              Navigator.of(context).pop();
            },
            title: "OK",
          ),
        ],
      ),
    );
  }
}
