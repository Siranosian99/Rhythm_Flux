import 'dart:math';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rhythm_flux/features/user/user_repository.dart';
import 'package:rhythm_flux/features/user/user_states.dart';

class UserCubit extends Cubit<UserState>{
  final UserRepository repository;
  UserCubit({
    required this.repository,
  }) : super(const UserState());
  Future<void> getUser()async{
    emit(state.copyWith(
      userStatus: UserStatus.loading,
      clearError: true,
      clearSuccess: true,
    ));
    try{
      await repository.getUser();
      emit(state.copyWith(
        userStatus: UserStatus.success,
        successMessage: "Get User successful",
          clearError: true,
        isGot: true
      ));
    }
    catch(e){
      emit(state.copyWith(
          userStatus: UserStatus.failure,
          errorMessage: "Failed to get user :$e",
          clearSuccess: true,
          isGot: false
      ));
    rethrow;

    }
  }
}