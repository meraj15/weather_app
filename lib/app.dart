import 'package:flutter/material.dart';
import 'package:practice_waether_app/sevices/api_service.dart';
import 'package:practice_waether_app/view/weather_app_screen.dart';
import 'package:practice_waether_app/view_model/weather_view_model.dart';
import 'package:provider/provider.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => WeatherViewModel(apiService: ApiService()),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter MVVM Map Demo',
        home: const WeatherApp(),
      ),
    );
  }
}
