import 'package:blogapp/core/entities/user.dart';
import 'package:blogapp/core/error/failures.dart';
import 'package:blogapp/core/usecase/useecase.dart';
import 'package:blogapp/features/auth/domian/resposistory/auth_reposistory.dart';
import 'package:fpdart/src/either.dart';

class CurrentUser implements UseCaseNoParmas<User> {
  final AuthRepository authRepository;

  CurrentUser({required this.authRepository});
  @override
  Future<Either<Failure, User>> call()async {
    return await authRepository.getCurrentUser();
  }
}
