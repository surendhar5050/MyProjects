import 'package:equatable/equatable.dart';
import 'package:ttd_project/core/usecase/usecase.dart';
import 'package:ttd_project/core/utils/typedef.dart';
import 'package:ttd_project/src/authencation/domain/reposistory/authentication_resposistory.dart';

class CreateUser extends UsecaseWithParams<void, CreateUserPrams> {
  const CreateUser(this._reposistory);

  final AuthenticationReposistory _reposistory;
  @override
  ResultVoid call(CreateUserPrams params) async => _reposistory.createUser(
      name: params.name, createdAt: params.createdAt, avatar: params.avatar);
}

class CreateUserPrams extends Equatable {
  final String createdAt;
  final String name;
  final String avatar;

  const CreateUserPrams(
      {required this.createdAt, required this.name, required this.avatar});

  @override
  List<Object?> get props => [createdAt, name, avatar];
}
