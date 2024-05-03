import 'package:blogapp/core/entities/user.dart';
import 'package:blogapp/core/error/failures.dart';
import 'package:blogapp/core/usecase/useecase.dart';
import 'package:fpdart/fpdart.dart';

import '../resposistory/auth_reposistory.dart';

class UserSignUp implements UseCase<User, UserSignUpParams> {
  final AuthRepository authRepository;

  UserSignUp(this.authRepository);

  // @override
  // Future<Either<Failure, dynamic>> call(UserSignUpParams params) async{

  //         return await authRepository.signUpWithEmailPassword(name:params.name, email:params. email, password:params. password);
  // }

  @override
  Future<Either<Failure, User>> call(UserSignUpParams params) async {
    return await authRepository.signUpWithEmailPassword(
        name: params.name, email: params.email, password: params.password);
  }
}

class UserSignUpParams {
  final String name;
  final String email;
  final String password;

  const UserSignUpParams(
      {required this.name, required this.email, required this.password});
}
