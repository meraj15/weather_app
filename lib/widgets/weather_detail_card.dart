import 'package:flutter/material.dart';
import 'package:practice_waether_app/constant/colors.dart';

class WeatherDetailCard extends StatelessWidget {
  final String title;
  final String value;
  final Widget leadingIcon;

  const WeatherDetailCard({
    super.key,
    required this.title,
    required this.value,
    required this.leadingIcon,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppColors.card,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          children: [
            leadingIcon,
            const SizedBox(width: 12.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      color: AppColors.textSecondary,
                      fontSize: 12,
                    ),
                  ),
                  Text(
                    value,
                    overflow: TextOverflow.visible,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
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
