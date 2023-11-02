import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tesis_app/providers/account_provider.dart';
import 'package:tesis_app/providers/map_provider.dart';
import 'package:tesis_app/providers/survey_provider.dart';
import 'package:tesis_app/shared/routes/app_routes.dart';
import 'package:tesis_app/shared/theme/app_theme.dart';
import 'package:tesis_app/views/splash_view.dart';

late SharedPreferences localStorage;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  localStorage = await SharedPreferences.getInstance();
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => MapProvider()),
      ChangeNotifierProvider(create: (_) => AccountProvider()),
      ChangeNotifierProvider(create: (_) => SurveyProvider()),
    ],
    child: const MyApp(),
  ));
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
