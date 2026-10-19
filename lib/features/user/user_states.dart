
enum UserStatus {
  initial,
  loading,
  success,
  failure,
}

class UserState {
  final UserStatus userStatus;
  final String? errorMessage;
  final String? successMessage;
  final bool isGot;

  const UserState({
    this.userStatus = UserStatus.initial,
    this.errorMessage,
    this.successMessage,
    this.isGot = false,
  });

  UserState copyWith({
    UserStatus? userStatus,
    String? errorMessage,
    String? successMessage,
    bool? isGot,
    bool clearError = false,
    bool clearSuccess = false,
  }) {
    return UserState(
      userStatus: userStatus ?? this.userStatus,
      errorMessage:
      clearError ? null : errorMessage ?? this.errorMessage,
      successMessage:
      clearSuccess ? null : successMessage ?? this.successMessage,
      isGot: isGot ?? this.isGot,
    );
  }
}
