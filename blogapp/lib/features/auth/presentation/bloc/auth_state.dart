part of 'auth_bloc.dart';

@immutable
sealed class AuthState {}

final class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class AuthSucess extends AuthState {

 final User res;

 AuthSucess({required this.res});
}

class AuthError extends AuthState {


  final String errorMsg;


  AuthError({required this.errorMsg});
}
