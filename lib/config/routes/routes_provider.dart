import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:go_router/go_router.dart';
import 'package:spotify_app/config/routes/app_routes.dart';
import 'package:spotify_app/config/routes/routes_location.dart';

part 'routes_provider.g.dart';

final navigationKey = GlobalKey<NavigatorState>();

// StateとなるGoRouteを監視
@riverpod
GoRouter goRouter(ref) {
  return GoRouter(
    initialLocation: AppRoute.auth.path, // アプリ起動時の初期画面のパス
    navigatorKey: navigationKey,
    routes: appRoutes // 定義済みのルートを設定
  );
}