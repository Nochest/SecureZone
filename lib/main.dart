import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tesis_app/providers/map_provider.dart';
import 'package:tesis_app/shared/routes/app_routes.dart';
import 'package:tesis_app/shared/theme/app_theme.dart';
import 'package:tesis_app/views/splash_view.dart';

void main() {
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(
      create: (_) => MapProvider(),
    )
  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      routes: AppRoutes.routes,
      initialRoute: SplashView.route,
      theme: AppTheme.appLightTheme,
      debugShowCheckedModeBanner: false,
    );
  }
}
