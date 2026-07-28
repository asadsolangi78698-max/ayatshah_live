import 'package:google_sign_in/google_sign_in.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import '../../../../core/services/api_service.dart';
import '../../../../core/services/storage_service.dart';
import '../../../../core/utils/constants.dart';
import '../models/user_model.dart';

class AuthRepository {
  AuthRepository(this._api, this._storage);

  final ApiService _api;
  final StorageService _storage;
  final GoogleSignIn _googleSignIn = GoogleSignIn(scopes: ['email', 'profile']);

  /// Step 1: request an OTP code be sent to [phone].
  Future<void> sendOtp(String phone) async {
    await _api.post(ApiEndpoints.sendOtp, data: {'phone': phone});
  }

  /// Step 2: verify the OTP and persist tokens on success.
  Future<UserModel> verifyOtp({required String phone, required String otp}) async {
    final response = await _api.post(
      ApiEndpoints.verifyOtp,
      data: {'phone': phone, 'otp': otp},
    );
    return _persistSession(response.data as Map<String, dynamic>);
  }

  Future<UserModel> loginWithGoogle() async {
    final account = await _googleSignIn.signIn();
    if (account == null) throw Exception('Google sign-in cancelled');
    final auth = await account.authentication;

    final response = await _api.post(
      ApiEndpoints.googleLogin,
      data: {'idToken': auth.idToken},
    );
    return _persistSession(response.data as Map<String, dynamic>);
  }

  Future<UserModel> loginWithApple() async {
    final credential = await SignInWithApple.getAppleIDCredential(
      scopes: [
        AppleIDAuthorizationScopes.email,
        AppleIDAuthorizationScopes.fullName,
      ],
    );

    final response = await _api.post(
      ApiEndpoints.appleLogin,
      data: {
        'identityToken': credential.identityToken,
        'authorizationCode': credential.authorizationCode,
      },
    );
    return _persistSession(response.data as Map<String, dynamic>);
  }

  Future<UserModel> loginAsGuest() async {
    final response = await _api.post(ApiEndpoints.guestLogin);
    return _persistSession(response.data as Map<String, dynamic>);
  }

  Future<void> logout() async {
    await _storage.clearAll();
    await _googleSignIn.signOut();
  }

  Future<UserModel> _persistSession(Map<String, dynamic> data) async {
    final accessToken = data['accessToken'] as String;
    final refreshToken = data['refreshToken'] as String;
    final user = UserModel.fromJson(data['user'] as Map<String, dynamic>);

    await _storage.saveAccessToken(accessToken);
    await _storage.saveRefreshToken(refreshToken);
    await _storage.setUserId(user.id);

    return user;
  }
}
