import 'package:tesis_app/shared/routes/routes.dart';

class AppRoutes {
  static final routes = {
    SplashView.route: (_) => const SplashView(),
    LoginView.route: (_) => const LoginView(),
    VerificationView.route: (_) => const VerificationView(),
    ReportMapview.route: (_) => const ReportMapview(),
    ProfileView.route: (_) => const ProfileView(),
    ReportView.route: (_) => const ReportView(),
    SurveyView.route: (_) => const SurveyView(),
    EmergencyNumbersView.route: (_) => const EmergencyNumbersView(),
    RegisterView.route: (_) => const RegisterView(),
    ConfigurationView.route: (_) => const ConfigurationView(),
    UpdateProfileView.route: (_) => const UpdateProfileView(),
  };
}
