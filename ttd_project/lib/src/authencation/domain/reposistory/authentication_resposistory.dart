import 'package:ttd_project/core/utils/typedef.dart';
import 'package:ttd_project/src/authencation/domain/entities/user.dart';

abstract class AuthenticationReposistory {
  const AuthenticationReposistory();

  ResultVoid createUser(
      {required String name,
      required String createdAt,
      required String avatar});

  ResultFuture<List<User>> getUser();
}
