import 'package:tesis_app/shared/routes/routes.dart';
import 'package:tesis_app/views/profile_view.dart';
import 'package:tesis_app/views/report_map_view.dart';
import 'package:tesis_app/views/report_view.dart';
import 'package:tesis_app/views/survey_view.dart';
import 'package:tesis_app/views/verification_view.dart';

class AppRoutes {
  static final routes = {
    SplashView.route: (_) => const SplashView(),
    LoginView.route: (_) => const LoginView(),
    VerificationView.route: (_) => const VerificationView(),
    ReportMapview.route: (_) => const ReportMapview(),
    ProfileView.route: (_) => const ProfileView(),
    ReportView.route: (_) => const ReportView(),
    SurveyView.route: (_) => const SurveyView(),
  };
}