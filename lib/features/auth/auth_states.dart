
enum AuthStatus {
  initial,
  loading,
  success,
  failure,
}

class AuthState {
  final AuthStatus status;
  final String? errorMessage;
  final String? successMessage;
  final bool isLoggedIn;

  const AuthState({
    this.status = AuthStatus.initial,
    this.errorMessage,
    this.successMessage,
    this.isLoggedIn = false,
  });

  AuthState copyWith({
    AuthStatus? status,
    String? errorMessage,
    String? successMessage,
    bool? isLoggedIn,
    bool clearError = false,
    bool clearSuccess = false,
  }) {
    return AuthState(
      status: status ?? this.status,
      errorMessage:
      clearError ? null : errorMessage ?? this.errorMessage,
      successMessage:
      clearSuccess ? null : successMessage ?? this.successMessage,
      isLoggedIn: isLoggedIn ?? this.isLoggedIn,
    );
  }
}
