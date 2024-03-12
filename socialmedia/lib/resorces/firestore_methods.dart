import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:socialmedia/models.dart/posts.dart';
import 'package:socialmedia/resorces/storage_methods.dart';
import 'package:uuid/uuid.dart';

class FirestoreMethods {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  upLoadpost(String description, Uint8List file, String uid, String userName,
      String profileimage) async {
    String res = 'Something went wrong';
    try {
      String postId = const Uuid().v1();

      ///v1 method generate unique id based on time
      String photoUrl =
          await Storagemethods().uplaodimageStorage('Posts', file, true);
      Posts posts = Posts(
          description: description,
          uid: uid,
          userName: userName,
          postId: postId,
          datePusblishd: DateTime.now(),
          postUrl: photoUrl,
          profileUrl: profileimage,
          likes: []);

      _firestore.collection('Posts').doc().set(posts.tojson());

      res = 'Sucess';
    } catch (e) {
      res = e.toString();
    }

    return res;
  }

  Future<void> updateLike(String postId, String uId, List likes) async {
    try {
      //   DocumentSnapshot doc = await _firestore.collection('Posts').doc(postId).get();
      //     if (!doc.exists) {
      //   print('Document with ID $postId does not exist');
      //   return;
      // }

      if (likes.contains(uId)) {
        await _firestore.collection('Posts').doc(postId).update({
          'likes': FieldValue.arrayRemove([uId]),
        });
      } else {
        await _firestore.collection('Posts').doc(postId).update({
          'likes': FieldValue.arrayUnion([uId]),
        });
      }
    } catch (e) {
      print(e);
    }
  }

  Future<void> postComment(String postId, String text, String uid, String name,
      String profilePic) async {
    try {
      if (text.isNotEmpty) {
        String commentId = Uuid().v1();
        await _firestore
            .collection('Posts')
            .doc(postId)
            .collection("comments")
            .doc(commentId)
            .set({
          'profilePics': profilePic,
          "Uname": name,
          "uid": uid,
          "tetx": text,
          'commentId': commentId,
          "datepublished": DateTime.now()
        });
        print('success');
      } else {
        print('texr is empty');
      }
    } catch (e) {
      print(e.toString());
    }
  }

  deletePost(String postId) async {
    try {
      await _firestore.collection('Posts').doc(postId).delete();
      print('delete Success fully');
    } catch (e) {
      print(e.toString());
    }
  }

  follow(String uid, String followId) async {
    try {
      DocumentSnapshot snap =
          await _firestore.collection('users').doc(uid).get();

      List following = (snap.data() as dynamic)['following'];
      if (!following.contains(followId)) {
        await _firestore.collection('users').doc(uid).update({
          'following': FieldValue.arrayRemove([followId])
        });
        await _firestore.collection('users').doc(followId).update({
          'followers': FieldValue.arrayRemove([uid])
        });
      } else {
        await _firestore.collection('users').doc(uid).update({
          'following': FieldValue.arrayUnion([followId])
        });
        await _firestore.collection('users').doc(followId).update({
          'followers': FieldValue.arrayUnion([uid])
        });
      }
    } catch (e) {}
  }
}
