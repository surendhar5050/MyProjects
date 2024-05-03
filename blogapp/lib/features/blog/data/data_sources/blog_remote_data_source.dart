import 'dart:io';

import 'package:blogapp/core/error/expections.dart';
import 'package:blogapp/features/blog/data/model/blog_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

abstract interface class BlogRemoteDataSource {
  Future<BlogModel> uploadBlog(BlogModel blog);

  Future<String> upLoadBlogImage({
    required File image,
    required BlogModel blogModel,
  });

  Future<List<BlogModel>> getAllBlogs();
}

class BlogRemoteDataSourceIml implements BlogRemoteDataSource {
  final FirebaseFirestore fireStore;
  final FirebaseStorage fireStorage;
  final FirebaseAuth fireAuth;

  BlogRemoteDataSourceIml(
      {required this.fireStore,
      required this.fireStorage,
      required this.fireAuth});
  @override
  Future<BlogModel> uploadBlog(BlogModel blog) async {
    try {
      await fireStore
          .collection('blogs')
          .doc(fireAuth.currentUser!.uid)
          .set(blog.toMap());

      final querySnapshot = await fireStore
          .collection("blogs")
          .doc(fireAuth.currentUser!.uid)
          .get();

      // final Map<String, dynamic> data = querySnapshot.data()!["topics"];

      // <String, dynamic>{
      //   'id': data['id'],
      //   'titile': data['titile'],
      //   'content': data['content'],
      //   'imageUrl': data['imageUrl'],
      //   'topics': data["topics"] ,
      //   'updateAt': data['updateAt'].toIso8601String(),
      // };
      return BlogModel.fromMap(querySnapshot.data()!);
    } catch (e) {
      print(e.toString());
      throw ServerException(e.toString());
    }
  }

  @override
  Future<String> upLoadBlogImage({
    required File image,
    required BlogModel blogModel,
  }) async {
    try {
      Reference _ref = fireStorage
          .ref()
          .child('blog_image')
          .child(fireAuth.currentUser!.uid);

      _ref = _ref.child(blogModel.id);

      UploadTask _task = _ref.putData(await image.readAsBytes());

      TaskSnapshot _taskSnapSnot = await _task;

      String downLoadurl = await _taskSnapSnot.ref.getDownloadURL();

      return downLoadurl;
    } catch (e) {
      print(e.toString());
      throw ServerException(e.toString());
    }
  }

  @override
  Future<List<BlogModel>> getAllBlogs() async {
    try {
      final listBlogs = await fireStore.collection("blogs").get();
      




      return (listBlogs.docs)
          .map((blogs) => BlogModel.fromMap(blogs.data()).copyWith(posterName:"Surendhar" ))
          .toList();

      // return [];
    } catch (e) {
      throw ServerException(e.toString());
    }
  }
}
