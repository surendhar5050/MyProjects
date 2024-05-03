import 'dart:io';

import 'package:blogapp/core/error/failures.dart';
import 'package:fpdart/fpdart.dart';

import '../entites/blog.dart';

abstract interface class BlogReposistory {
  Future<Either<Failure, Blog>> uploadBlog(
      {required File image,
      required String title,
      required String content,
      required List<String> topics});


      Future<Either<Failure,List<Blog>>> getAllBlogs();
}
