import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:spotify_app/app.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(
    // アプリ全体でriverpodを使用できるようProviderScopeでラップ
    const ProviderScope(
      child: RiverpodToDoApp(),
    ),
  );
}
