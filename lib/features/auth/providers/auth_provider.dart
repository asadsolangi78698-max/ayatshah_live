import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/services/core_providers.dart';
import '../data/models/user_model.dart';
import '../data/repositories/auth_repository.dart';

enum AuthStatus { unknown, authenticated, unauthenticated }

class AuthState {
  const AuthState({
    this.status = AuthStatus.unknown,
    this.user,
    this.isLoading = false,
    this.error,
  });

  final AuthStatus status;
  final UserModel? user;
  final bool isLoading;
  final String? error;

  AuthState copyWith({
    AuthStatus? status,
    UserModel? user,
    bool? isLoading,
    String? error,
  }) {
    return AuthState(
      status: status ?? this.status,
      user: user ?? this.user,
      isLoading: isLoading ?? this.isLoading,
      error: error,
    );
  }
}

final authRepositoryProvider = Provider<AuthRepository>((ref) {
  final api = ref.watch(apiServiceProvider);
  final storage = ref.watch(storageServiceProvider);
  return AuthRepository(api, storage);
});

class AuthNotifier extends StateNotifier<AuthState> {
  AuthNotifier(this._repository) : super(const AuthState()) {
    _bootstrap();
  }

  final AuthRepository _repository;

  Future<void> _bootstrap() async {
    // TODO: check stored token validity / fetch current profile.
    state = state.copyWith(status: AuthStatus.unauthenticated);
  }

  Future<void> sendOtp(String phone) async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      await _repository.sendOtp(phone);
      state = state.copyWith(isLoading: false);
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }

  Future<void> verifyOtp({required String phone, required String otp}) async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final user = await _repository.verifyOtp(phone: phone, otp: otp);
      state = state.copyWith(
        isLoading: false,
        status: AuthStatus.authenticated,
        user: user,
      );
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }

  Future<void> loginWithGoogle() => _runLogin(_repository.loginWithGoogle);
  Future<void> loginWithApple() => _runLogin(_repository.loginWithApple);
  Future<void> loginAsGuest() => _runLogin(_repository.loginAsGuest);

  Future<void> _runLogin(Future<UserModel> Function() action) async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final user = await action();
      state = state.copyWith(
        isLoading: false,
        status: AuthStatus.authenticated,
        user: user,
      );
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }

  Future<void> logout() async {
    await _repository.logout();
    state = const AuthState(status: AuthStatus.unauthenticated);
  }
}

final authProvider = StateNotifierProvider<AuthNotifier, AuthState>((ref) {
  final repository = ref.watch(authRepositoryProvider);
  return AuthNotifier(repository);
});
