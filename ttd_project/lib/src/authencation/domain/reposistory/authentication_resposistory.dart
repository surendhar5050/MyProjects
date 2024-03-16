import 'package:ttd_project/core/utils/typedef.dart';

abstract class AuthenticationReposistory {
  const AuthenticationReposistory();

  ResultFuture createUser(
      {required String name,
      required String createdAt,
      required String avatar});

  ResultVoid getUser();
}
