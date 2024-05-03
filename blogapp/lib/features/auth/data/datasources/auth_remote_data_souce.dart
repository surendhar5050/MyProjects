import 'package:blogapp/core/error/expections.dart';
import 'package:blogapp/features/auth/data/model/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as fb;

abstract interface class AuthRemoteDataSource {
  fb.User? get currentUserSession;

  Future<UserModel> signUpWithEmailPassword(
      {required String name, required String email, required String password});
  Future<UserModel> loginEmailPassword(
      {required String email, required String password});

  Future<UserModel?> getCurrentUser();
}

class ImplementAuthencation implements AuthRemoteDataSource {
  final fb.FirebaseAuth firebaseAuth;
  final FirebaseFirestore firebaseFirestore;
  ImplementAuthencation(
      {required this.firebaseAuth, required this.firebaseFirestore});

  @override
  fb.User? get currentUserSession => firebaseAuth.currentUser;

  @override
  Future<UserModel> loginEmailPassword({
    required String email,
    required String password,
  }) async {
    try {
      final response = await firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);

      if (response.user == null) {
        throw const ServerException("User is null");
      } else {
        // await firebaseFirestore
        //     .collection('profiles')
        //     .doc(response.user!.uid)
        //     .set({
        //       "id":response.user!.uid,
        //   "name": name,
        //   "email": email,
        // });
        final querySnapshot = await firebaseFirestore
            .collection("profiles")
            .doc(response.user!.uid)
            .get();

        print(querySnapshot.data());

        //  querySnapshot.data();
        return UserModel.fromjson(querySnapshot.data()!);
      }
    } catch (e) {
      throw const ServerException("User is null");
    }
  }

  @override
  Future<UserModel> signUpWithEmailPassword({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      final response = await firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);

      if (response.user == null) {
        throw const ServerException("User is null");
      } else {
        await firebaseFirestore
            .collection('profiles')
            .doc(response.user!.uid)
            .set({
          "id": response.user!.uid,
          "name": name,
          "email": email,
        });

        return UserModel.fromjson({
          "id": response.user!.uid,
          "name": name,
          "email": email,
        });
      }
    } catch (e) {
      throw const ServerException("User is null");
    }
  }

  @override
  Future<UserModel?> getCurrentUser() async {
    try {
      if (currentUserSession != null) {
        final token = firebaseAuth.getRedirectResult();
        // final user =
        //     await firebaseAuth.authStateChanges().asBroadcastStream().first;

        // firebaseFirestore
        //     .collection("profiles")
        //     .where("id", isEqualTo: currentUserSession!.uid);
        // String name = "";
        // await firebaseFirestore
        //     .collection("profiles")
        //     .where("id", isEqualTo: user!.uid)
        //     .get()
        //     .then((querySnapshot) {
        //   if (querySnapshot.docs.isNotEmpty) {
        //     // Access first document (assuming there's only one user per ID)
        //     name = querySnapshot.docs.first.data()["name"];
        //   } else {
        //     // Handle case where no documents are found (optional)
        //     print("No user profile found");
        //   }
        // });
        // return UserModel.fromjson({
        //   "id": user!.uid,
        //   "name": name,
        //   "email": user.email,
        // });
      }
    } catch (e) {
      throw ServerException(e.toString());
    }
    return null;
  }

  currentUser() {
    try {
      firebaseAuth.authStateChanges().asBroadcastStream().first;
    } catch (e) {
      //
    }
  }
}
