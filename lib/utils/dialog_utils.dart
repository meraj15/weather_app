import 'package:flutter/material.dart';
import 'package:practice_waether_app/widgets/app_button.dart';

class DialogUtils {
  static void showErrorDialog(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text("City Not Found"),
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
