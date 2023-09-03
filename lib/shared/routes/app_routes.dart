import 'package:tesis_app/shared/routes/routes.dart';
import 'package:tesis_app/views/verification_view.dart';

class AppRoutes {
  static final routes = {
    SplashView.route: (_) => const SplashView(),
    LoginView.route: (_) => const LoginView(),
    VerificationView.route: (_) => const VerificationView(),
  };
}
