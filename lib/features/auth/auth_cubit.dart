
import 'package:flutter_bloc/flutter_bloc.dart';


import 'auth_repository.dart';
import 'auth_states.dart';

class AuthCubit extends Cubit<AuthState> {
  final AuthRepository repository;

  AuthCubit({
    required this.repository,
  }) : super(const AuthState());

  Future<void> createAccount({
    required String email,
    required String password,
  }) async {
    emit(
      state.copyWith(
        status: AuthStatus.loading,
        clearError: true,
        clearSuccess: true,
      ),
    );

    try {
      await repository.createAccount(
        email: email,
        password: password,
      );

      emit(
        state.copyWith(
          status: AuthStatus.success,
          successMessage: 'Hesap başarıyla oluşturuldu.',
          clearError: true,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          status: AuthStatus.failure,
          errorMessage: e.toString(),
          clearSuccess: true,
        ),
      );
    }
  }

  Future<void> login({
    required String email,
    required String password,
  }) async {
    emit(
      state.copyWith(
        status: AuthStatus.loading,
        clearError: true,
        clearSuccess: true,
      ),
    );

    try {
      final result = await repository.login(
        email: email,
        password: password,
      );

      if (result == true) {
        emit(
          state.copyWith(
            status: AuthStatus.success,
            isLoggedIn: true,
            successMessage: 'Login Successes.',
            clearError: true,
          ),
        );
      } else {
        emit(
          state.copyWith(
            status: AuthStatus.failure,
            isLoggedIn: false,
            errorMessage: 'Login Failed.',
            clearSuccess: true,
          ),
        );
      }
    } catch (e) {
      emit(
        state.copyWith(
          status: AuthStatus.failure,
          isLoggedIn: false,
          errorMessage: e.toString(),
          clearSuccess: true,
        ),
      );
    }
  }

  Future<bool> refreshAccessToken() async {
    return repository.refreshAccessToken();
  }

  void resetStatus() {
    emit(const AuthState());
  }
}
