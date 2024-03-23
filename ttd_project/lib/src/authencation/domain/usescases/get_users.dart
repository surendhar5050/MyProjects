import 'package:ttd_project/core/usecase/usecase.dart';
import 'package:ttd_project/src/authencation/domain/entities/user.dart';
import 'package:ttd_project/src/authencation/domain/reposistory/authentication_resposistory.dart';

class GetUsers  extends UsecaseWithOutParams<List<User>> {
  final AuthenticationReposistory _resposistory;

  GetUsers(this._resposistory);



}
