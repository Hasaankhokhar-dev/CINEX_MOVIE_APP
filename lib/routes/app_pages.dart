import 'package:cinex_movie_app/features/auth/views/create_new_password.dart';
import 'package:cinex_movie_app/features/auth/views/forgot_password.dart';
import 'package:cinex_movie_app/features/auth/views/login_view.dart';
import 'package:cinex_movie_app/features/auth/views/otp_verification.dart';
import 'package:cinex_movie_app/features/auth/views/password_changed.dart';
import 'package:cinex_movie_app/features/auth/views/signup_view.dart';
import 'package:cinex_movie_app/features/movie_screens/nav_bar/main_view.dart';
import 'package:cinex_movie_app/features/movie_screens/views/detail_view.dart';
import 'package:cinex_movie_app/features/movie_screens/views/favorites_view.dart';
import 'package:cinex_movie_app/features/movie_screens/views/home_view.dart';
import 'package:cinex_movie_app/features/movie_screens/views/search_view.dart';
import 'package:get/get.dart';
import '../features/auth/views/onboarding_view.dart';
import '../features/movie_screens/views/genres_view.dart';
import '../features/splash/views/splash_view.dart';
import 'app_routes.dart';

class AppPages {
  static final routes =[
    GetPage(name: AppRoutes.splash, page: () => const SplashView()),
    GetPage(name: AppRoutes.onboarding, page: () => const OnboardingView()),
    GetPage(name: AppRoutes.signup, page: () => const SignupView()),
    GetPage(name: AppRoutes.login, page: () => const LoginView()),
    GetPage(name: AppRoutes.forgotPassword, page: () => const ForgotPassword()),
    GetPage(name: AppRoutes.otpVerification, page: () => const OtpVerification()),
    GetPage(name: AppRoutes.createNewPassword, page: () => const CreateNewPassword()),
    GetPage(name: AppRoutes.passwordChanged, page: () => const PasswordChanged()),
    GetPage(name: AppRoutes.home, page: () => const MainView()),
    GetPage(name: AppRoutes.favorites, page: () => const FavoritesView()),
    GetPage(name: AppRoutes.search, page: () => const SearchView()),
    GetPage(name: AppRoutes.genres, page: () => const GenresView()),
  ];
}
