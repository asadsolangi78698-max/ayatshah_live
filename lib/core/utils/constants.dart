class AppConstants {
  AppConstants._();

  static const String appName = 'AyatShah Live';

  // Update to your real backend base URL
  static const String baseUrl = 'https://api.ayatshahlive.com/v1';
  static const String socketUrl = 'wss://socket.ayatshahlive.com';

  // Storage keys
  static const String keyAccessToken = 'access_token';
  static const String keyRefreshToken = 'refresh_token';
  static const String keyUserId = 'user_id';
  static const String keyOnboardingSeen = 'onboarding_seen';

  // Audio party room
  static const int minMicSeats = 8;
  static const int maxMicSeats = 12;

  // PK battle
  static const int pkDurationSeconds = 180;

  // Pagination
  static const int defaultPageSize = 20;
}

class ApiEndpoints {
  ApiEndpoints._();

  static const String sendOtp = '/auth/otp/send';
  static const String verifyOtp = '/auth/otp/verify';
  static const String googleLogin = '/auth/google';
  static const String appleLogin = '/auth/apple';
  static const String guestLogin = '/auth/guest';

  static const String profile = '/users/me';
  static const String updateProfile = '/users/me';

  static const String liveList = '/live/list';
  static const String liveStart = '/live/start';
  static const String liveEnd = '/live/end';
  static const String liveJoin = '/live/join';

  static const String audioRooms = '/audio-rooms';
  static const String pkBattles = '/pk-battles';

  static const String wallet = '/wallet';
  static const String recharge = '/wallet/recharge';
  static const String withdraw = '/wallet/withdraw';

  static const String gifts = '/gifts';
  static const String sendGift = '/gifts/send';

  static const String chats = '/chats';
  static const String messages = '/chats/messages';
}
