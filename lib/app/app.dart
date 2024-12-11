import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:spotify_app/config/routes/routes.dart';

class RiverpodToDoApp extends ConsumerWidget {
  const RiverpodToDoApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final route = ref.watch(goRouterProvider);

    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      routerConfig: route,
    );
  }
}
