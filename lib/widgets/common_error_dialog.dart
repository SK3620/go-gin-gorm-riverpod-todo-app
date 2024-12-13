import 'package:flutter/material.dart';
import 'package:spotify_app/config/routes/routes.dart';
import 'package:spotify_app/model/failure_model.dart';

class CommonErrorDialog {
  static Future<void> show({
    required FailureModel error,
  }) {
    return showDialog(
      context: navigationKey.currentContext!,
      builder: (_) {
        return AlertDialog(
          title: const Text('エラー'),
          content: Text('${error.message}\n\n${error.detail}'),
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
