import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  final String userName;
  final String uid;
  final String email;
  final String bio;
  final String photoUrl;
  final List followers;
  final List following;

  const User(
      {required this.userName,
      required this.uid,
      required this.email,
      required this.bio,
      required this.photoUrl,
      required this.followers,
      required this.following});

  Map<String, dynamic> tojson() => {
        'userName': userName,
        'uid': uid,
        'e-mail': email,
        'bio': bio,
        'follwers': followers,
        'following': following,
        'profilepics': photoUrl
      };

  static User fromDocumentSnapshot(DocumentSnapshot snap) {
    var snapshot = (snap.data()) as Map<String, dynamic>;

    return User(
        userName: snapshot['userName'],
        uid: snapshot['uid'],
        email: snapshot['e-mail'],
        bio: snapshot['bio'],
        photoUrl: snapshot['profilepics'],
        followers: snapshot['follwers'],
        following: snapshot['following']);
  }
}
