import 'dart:convert';
import 'package:cinex_movie_app/features/auth/models/user_model.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;
import '../firebase_constants/firebase_constants.dart';

class AuthService {
  static final _box = GetStorage();
  static final _googleSignIn = GoogleSignIn();

  static Future<UserModel?> signUp(String email, String password) async {
    try {
      final response = await http.post(
        Uri.parse(
          '${FirebaseConstants.signUp}?key=${FirebaseConstants.apiKey}',
        ),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'email': email,
          'password': password,
          'returnSecureToken': true,
        }),
      );
      final data = jsonDecode(response.body);
      if (response.statusCode != 200) {
        final error = data['error']['message'];
        throw _handleError(error);
      }
      final user = UserModel.fromJson(data);
      _saveUser(user);
      return user;
    } catch (e) {
      rethrow;
    }
  }

  static Future<UserModel?> signIn(String email, String password, bool rememberMe) async {
    try {
      final response = await http.post(
        Uri.parse(
          '${FirebaseConstants.signIn}?key=${FirebaseConstants.apiKey}',
        ),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'email': email,
          'password': password,
          'returnSecureToken': true,
        }),
      );

      final data = jsonDecode(response.body);

      if (response.statusCode != 200) {
        final error = data['error']['message'];
        throw _handleError(error);
      }

      final user = UserModel.fromJson(data);
      if (rememberMe) {
        _saveUser(user);
      }
      return user;
    } catch (e) {
      rethrow;
    }
  }

  static Future<void> forgotPassword(String email) async {
    try {
      final response = await http.post(
        Uri.parse(
          '${FirebaseConstants.forgotPassword}?key=${FirebaseConstants.apiKey}',
        ),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'requestType': 'PASSWORD_RESET', 'email': email}),
      );

      final data = jsonDecode(response.body);

      if (response.statusCode != 200) {
        final errorCode = data['error']['message'];
        throw _handleError(errorCode);
      }
    } catch (e) {
      rethrow;
    }
  }

  static Future<UserModel?> signInWithGoogle() async {
    try {
      // Step 1: Google account select karwao
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();

      // User ne cancel kiya
      if (googleUser == null) return null;

      // Step 2: Google se tokens lo
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      // Step 3: Google idToken Firebase ko bhejo verify karne ke liye
      final response = await http.post(
        Uri.parse(
            '${FirebaseConstants.signInWithGoogle}?key=${FirebaseConstants.apiKey}'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'postBody': 'id_token=${googleAuth.idToken}&providerId=google.com',
          'requestUri': 'http://localhost',
          'returnIdpCredential': true,
          'returnSecureToken': true,
        }),
      );

      final data = jsonDecode(response.body);

      if (response.statusCode != 200) {
        final error = data['error']['message'];
        throw _handleError(error);
      }

      final user = UserModel.fromJson(data);
      _saveUser(user);
      return user;
    } catch (e) {
      rethrow;
    }
  }

  static void logout() {
    _box.erase();
    _googleSignIn.signOut();
  }

  static bool isLoggedIn() {
    return _box.read('idToken') != null;
  }

  static String? getToken() {
    return _box.read('idToken');
  }

  static void _saveUser(UserModel user) {
    _box.write('idToken', user.idToken);
    _box.write('email', user.email);
    _box.write('refreshToken', user.refreshToken);
    _box.write('localId', user.localId);
  }

  static String _handleError(String errorCode) {
    switch (errorCode) {
      case 'EMAIL_EXISTS':
        return 'Email already exists';
      case 'INVALID_PASSWORD':
        return 'Invalid password';
      case 'EMAIL_NOT_FOUND':
        return 'Email not found';
      case 'WEAK_PASSWORD':
        return 'Password should be at least 6 characters';
      case 'INVALID_LOGIN_CREDENTIALS':
        return 'Invalid login credentials';
      case 'TOO_MANY_ATTEMPTS_TRY_LATER':
        return 'Too many attempts, please try again later';
      default:
        return 'Something went wrong';
    }
  }
}
