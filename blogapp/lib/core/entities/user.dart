import 'package:equatable/equatable.dart';

class User extends Equatable{

  final String id;
  final String email;
  final String name;
 const User({
    required this.id,
    required this.email,
    required this.name
  });
  
  @override
  // TODO: implement props
  List<Object?> get props => [id,email,name];

  @override
    bool? get stringify => true;

}