import 'package:blogapp/core/entities/user.dart';
import 'package:blogapp/core/error/failures.dart';
import 'package:fpdart/fpdart.dart';

abstract interface class AuthRepository {
  Future<Either<Failure, User>> signUpWithEmailPassword(
      {required String name, required String email, required String password});

  Future<Either<Failure, User>> loginWithPassword(
      {required String email, required String password});

  Future<Either<Failure, User>> getCurrentUser();
}
