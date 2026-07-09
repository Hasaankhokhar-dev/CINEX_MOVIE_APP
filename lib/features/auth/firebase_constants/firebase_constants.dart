import 'package:flutter_dotenv/flutter_dotenv.dart';

class FirebaseConstants {
  static final String apiKey = dotenv.env['FIREBASE_API_KEY'] ?? '';

  static const String baseUrl = 'https://identitytoolkit.googleapis.com/v1/accounts';

  static const String signUp = '$baseUrl:signUp';
  static const String signIn = '$baseUrl:signInWithPassword';
  static const String forgotPassword = '$baseUrl:sendOobCode';

  static const String signInWithGoogle = 'https://identitytoolkit.googleapis.com/v1/accounts:signInWithIdp';
}