import 'package:flutter/material.dart';

import '../../../../core/errors.dart';

class ImageUtils
{



  static void showErrorMsg(BuildContext context) async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          title: const Text('No Internet'),
          content: const Text('Please check your network connection.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }
}