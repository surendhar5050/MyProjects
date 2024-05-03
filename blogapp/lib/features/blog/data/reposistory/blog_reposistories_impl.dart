import 'dart:io';

import 'package:blogapp/core/error/expections.dart';
import 'package:blogapp/core/error/failures.dart';
import 'package:blogapp/features/blog/data/data_sources/blog_remote_data_source.dart';
import 'package:blogapp/features/blog/data/model/blog_model.dart';
import 'package:blogapp/features/blog/domain/entites/blog.dart';
import 'package:blogapp/features/blog/domain/reposistory/blog_reposistory.dart';
import 'package:fpdart/src/either.dart';
import 'package:uuid/uuid.dart';

class BlogReposistoryImp implements BlogReposistory {
  final BlogRemoteDataSource blogRemoteDataSource;

  BlogReposistoryImp({required this.blogRemoteDataSource});
  @override
  Future<Either<Failure, Blog>> uploadBlog({
    required File image,
    required String title,
    required String content,
    required List<String> topics,
  }) async {
    try {
      final uid = const Uuid().v1();

      BlogModel blogModel = BlogModel(
        id: uid,
        titile: title,
        content: content,
        imageUrl: '',
        topics: topics,
        updateAt: DateTime.now(),
      );

      final imageUrl = await blogRemoteDataSource.upLoadBlogImage(
        image: image,
        blogModel: blogModel,
      );
      blogModel = blogModel.copyWith(imageUrl: imageUrl);
      final upLoadedBlog = await blogRemoteDataSource.uploadBlog(blogModel);
//   final demo=  await blogRemoteDataSource.getAllBlogs();
// demo.forEach((element) { print(element.id);});

      return right(upLoadedBlog);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, List<Blog>>> getAllBlogs() async {
    try {
      final blogs = await blogRemoteDataSource.getAllBlogs();

      return right(blogs);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }
}
