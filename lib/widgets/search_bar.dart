import 'package:flutter/material.dart';
import 'package:practice_waether_app/view_model/weather_view_model.dart';
import 'package:provider/provider.dart';

class WeatherSearchBar extends StatelessWidget {
  final TextEditingController userSearch;
  const WeatherSearchBar({super.key, required this.userSearch});

  @override
  Widget build(BuildContext context) {
     final weatherViewModel = Provider.of<WeatherViewModel>(context);
    return Padding(
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
          );
  }
}