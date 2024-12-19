import 'package:flutter/material.dart';
import 'package:spotify_app/config/routes/routes.dart';
import 'package:spotify_app/model/custom_exception.dart';

class CommonErrorDialog {
  static Future<void> show({
    required CustomException exception,
  }) {
    return showDialog(
      context: navigationKey.currentContext!,
      builder: (_) {
        return AlertDialog(
          title: const Text('エラー'),
          content: Text('${exception.message}\n\n${exception.message}'),
          actions: <Widget>[
            TextButton(
              child: const Text("確認"),
              onPressed: () => Navigator.pop(navigationKey.currentContext!),
            ),
          ],
        );
      },
    );
  }
}
