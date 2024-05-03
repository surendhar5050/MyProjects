import 'dart:async';

import 'package:blogapp/core/common/cubits/user/app_user_cubit.dart';
import 'package:blogapp/core/entities/user.dart';
import 'package:blogapp/features/auth/domian/usescase/current_user.dart';
import 'package:blogapp/features/auth/domian/usescase/user_login.dart';
import 'package:blogapp/features/auth/domian/usescase/user_sign_up.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final UserSignUp _userSignUp;
  final UserLogin _userLogin;
  final CurrentUser _currentUser;
  final AppUserCubit _appUserCubit;
  AuthBloc({
    required UserSignUp userSignUp,
    required UserLogin userLogin,
    required CurrentUser currentUser,
    required AppUserCubit appUserCubit,
  })  : _userSignUp = userSignUp,
        _userLogin = userLogin,
        _currentUser = currentUser,
        _appUserCubit = appUserCubit,
        super(AuthInitial()) {
    // on<AuthEvent>((_, emit) => emit(AuthLoading()));

    on<AuthSignIn>(authSignIn);
    on<AuthLogin>(authLogin);
    // on<AuthIsUserLoggedIn>(authIsUserLoggedIn);
  }

  FutureOr<void> authSignIn(AuthSignIn event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    final res = await _userSignUp(UserSignUpParams(
      name: event.name,
      email: event.email,
      password: event.password,
    ));
    //  final res= await  _userSignUp.call(UserSignUpParams(name: event.name, email: event.email, password: event.password));

    res.fold((failure) => emit(AuthError(errorMsg: failure.message)),
        (user) => emit(AuthSucess(res: user)));
  }

  FutureOr<void> authLogin(AuthLogin event, Emitter<AuthState> emit) async {
    emit(AuthLoading());

    final res = await _userLogin(
        UserLoginParams(email: event.email, password: event.password));





    res.fold((failure) => emit(AuthError(errorMsg: failure.message)),
        (user) => emit(AuthSucess(res: user)));
  }

  // FutureOr<void> authIsUserLoggedIn(
  //     AuthIsUserLoggedIn event, Emitter<AuthState> emit) async {
  //   final res = await _currentUser.call();

  //   res.fold((failure) {
  //     emit(AuthError(errorMsg: failure.message));
  //   }, (user) => _emitAuthSucess(user, emit)

  //       // {
  //       //   print(user);
  //       //   emit(AuthSucess(res: user));
  //       // }

  //       );
  // }

  // void _emitAuthSucess(User user, Emitter<AuthState> emitter) {
  //   _appUserCubit.updateUSer(user);

  //   emit(AuthSucess(res: user));
  // }
}
