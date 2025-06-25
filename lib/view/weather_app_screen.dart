import 'package:flutter/material.dart';
import 'package:practice_waether_app/constant/colors.dart';
import 'package:practice_waether_app/utils/dialog_utils.dart';
import 'package:practice_waether_app/view_model/weather_view_model.dart';
import 'package:practice_waether_app/widgets/search_bar.dart';
import 'package:practice_waether_app/widgets/weather_card.dart';
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
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<WeatherViewModel>().fetchResponse(cityName);
    });
  }

  @override
  Widget build(BuildContext context) {
    final weatherViewModel = Provider.of<WeatherViewModel>(context);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (weatherViewModel.errorMessage != null &&
          weatherViewModel.errorMessage!.isNotEmpty) {
        DialogUtils.showErrorDialog(context, weatherViewModel.errorMessage!);
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
          WeatherSearchBar(userSearch: userSearch),
          const SizedBox(height: 15),
          WeatherCard(vm: weatherViewModel), // 👈 Always show WeatherCard
        ],
      ),
    );
  }
}
