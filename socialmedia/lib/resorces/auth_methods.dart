import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:socialmedia/models.dart/user.dart' as model;
// import 'package:firebase_core/firebase_core.dart';
// import 'package:flutter/material.dart';
import 'package:socialmedia/resorces/storage_methods.dart';

class AuthMethods {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<model.User> getcurrentUser() async {
    User currentUser = _auth.currentUser!;

    DocumentSnapshot snap =
        await firestore.collection('users').doc(currentUser.uid).get();

    return model.User.fromDocumentSnapshot(snap);
  }

  signUpUser(
      {required String email,
      required String password,
      required String userName,
      required String bio,
      required Uint8List file}) async {
    String res = 'Some error occur';

    try {
      if (email.isNotEmpty ||
          password.isNotEmpty ||
          userName.isNotEmpty ||
          bio.isNotEmpty ||
          // ignore: unnecessary_null_comparison
          file != null) {
        UserCredential cred = await _auth.createUserWithEmailAndPassword(
            email: email, password: password);
        print(cred.user!.uid);

        String downLoadurl = await Storagemethods()
            .uplaodimageStorage('profilepics', file, false);
        model.User user = model.User(
            userName: userName,
            uid: cred.user!.uid,
            email: email,
            bio: bio,
            photoUrl: downLoadurl,
            followers: [],
            following: []);

        await firestore
            .collection('users')
            .doc(cred.user!.uid)
            .set(user.tojson());

        //  await   firestore.collection('users').add({
        //       'userName':userName,
        //       'uid':cred.user!.uid,
        //       'e-mail':email,
        //       'bio':bio,
        //       'follwers':[],
        //       'following':[]

        // });

        res = 'sucess';
      }
    } catch (err) {
      res = err.toString();
    }

    return res;
  }

  Future<String> loginUser(
      {required String email, required String password}) async {
    String res = 'some error occured';
    try {
      if (email.isNotEmpty || password.isNotEmpty) {
        await _auth.signInWithEmailAndPassword(
            email: email, password: password);
        res = 'sucess';
      }
    } catch (err) {
      res = err.toString();
    }
    return res;
  }

signOut()async{
await _auth.signOut();
}
}
