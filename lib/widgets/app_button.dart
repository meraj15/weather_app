import 'package:flutter/material.dart';
import 'package:practice_waether_app/constant/colors.dart';

class AppButton extends StatelessWidget {
  final double height;
  final double width;
  final VoidCallback onTap;
  final String title;
  const AppButton({super.key, required this.height, required this.width, required this.onTap, required this.title});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
                    // onTap: () {
                    //   Navigator.of(context).push(
                    //     MaterialPageRoute(
                    //       builder: (context) => DetailedWeatherScreen(weatherResponse: data,),
                    //     ),
                    //   );
                    // },
                    onTap:onTap ,
                    child: Container(
                      width: width,
                      height: height,
                      decoration: BoxDecoration(
                        color: AppColors.primary,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child:  Center(
                        child: Text(
                          title,
                          style: TextStyle(color: AppColors.card),
                        ),
                      ),
                    ),
                  );
  }
}