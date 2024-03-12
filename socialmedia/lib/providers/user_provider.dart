
// import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:socialmedia/models.dart/user.dart';
import 'package:socialmedia/resorces/auth_methods.dart';

class UserProvider with ChangeNotifier{
  User ? _user;

  AuthMethods _authMethods=AuthMethods();


  User ?get getUser=> _user;


 Future<void> refreshUser()async{
      User user =await _authMethods.getcurrentUser();
      _user=user;
      notifyListeners();
  }
}