import 'package:dartz/dartz.dart';

typedef ResultFuture<T> = Future<Either<Exception,T>>;


typedef ResultVoid<T> = Future<Either<Exception,void>>;



