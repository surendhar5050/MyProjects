part of 'auth_bloc.dart';

@immutable
sealed class AuthEvent {}

class AuthSignIn extends AuthEvent {
  final String name;
  final String email;
  final String password;

  AuthSignIn({
    required this.name,
    required this.email,
    required this.password,
  });
}

class AuthLogin extends AuthEvent {
  final String email;
  final String password;

  AuthLogin({required this.email, required this.password});
}


class AuthIsUserLoggedIn extends AuthEvent{
  
}
