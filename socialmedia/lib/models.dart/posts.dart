import 'package:cloud_firestore/cloud_firestore.dart';

class Posts {
  final String description;
  final String uid;
  final String userName;
  final String postId;
  final  datePusblishd;
  final String postUrl;
  final String profileUrl;
  final likes;

  const Posts(
      {required this.description,
      required this.uid,
      required this.userName,
      required this.postId,
      required this.datePusblishd,
      required this.postUrl,
      required this.profileUrl,
      required this.likes});

  Map<String, dynamic> tojson() => {
        "description": description,
        "uid": uid,
        "userName": userName,
        "postId": postId,
        "datePusblishd": datePusblishd,
        "postUrl": postUrl,
        "profileUrl": profileUrl,
        "likes": likes
      };

  static Posts fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;

    return Posts(
        description: snapshot['description'],
        uid: snapshot['uid'],
        userName: snapshot['userName'],
        postId: snapshot['postId'],
        datePusblishd: snapshot['datePusblishd'],
        postUrl: snapshot['postUrl'],
        profileUrl: snapshot['profileUrl'],
        likes: snapshot['likes']);
  }
}
