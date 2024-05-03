import 'dart:io';

import 'package:blogapp/core/error/failures.dart';
import 'package:blogapp/core/usecase/useecase.dart';
import 'package:blogapp/features/blog/domain/entites/blog.dart';
import 'package:blogapp/features/blog/domain/reposistory/blog_reposistory.dart';
import 'package:fpdart/fpdart.dart';

class UploadBlog implements UseCase<Blog, UploadBlogParams> {
  final BlogReposistory blogReposistory;

  UploadBlog({required this.blogReposistory});
  
  @override
  Future<Either<Failure, Blog>> call(UploadBlogParams params)async {
    return await  blogReposistory.uploadBlog(
        image: params.image,
        title: params.titile,
        content: params.content,
        topics: params.topics,
      );
  }

  
}

class UploadBlogParams {
  final String titile;
  final String content;
  final File image;
  final List<String> topics;

  UploadBlogParams({
    required this.titile,
    required this.content,
    required this.image,
    required this.topics,
  });
}
