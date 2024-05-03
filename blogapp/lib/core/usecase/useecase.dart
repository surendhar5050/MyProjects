import 'package:blogapp/core/error/failures.dart';
import 'package:fpdart/fpdart.dart';

abstract interface class UseCase<Successtype, Params> {
  Future<Either<Failure, Successtype>> call(Params params);
}

abstract interface class UseCaseNoParmas<Successtype> {
  Future<Either<Failure, Successtype>> call();
}
