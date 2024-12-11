import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:go_router/go_router.dart';
import 'package:spotify_app/config/routes/app_routes.dart';
import 'package:spotify_app/config/routes/routes_location.dart';

part 'routes_provider.g.dart';

final navigationKey = GlobalKey<NavigatorState>();

@riverpod
GoRouter goRouter(ref) {
  return GoRouter(
    initialLocation: AppRoute.auth.path,
    navigatorKey: navigationKey,
    routes: appRoutes
  );
}