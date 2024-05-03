import 'package:blogapp/core/error/failures.dart';
import 'package:blogapp/core/usecase/useecase.dart';
import 'package:blogapp/features/blog/domain/entites/blog.dart';
import 'package:blogapp/features/blog/domain/reposistory/blog_reposistory.dart';
import 'package:fpdart/fpdart.dart';

class GetAllBlogs implements UseCaseNoParmas<List<Blog>>{

  final BlogReposistory blogReposistory;

  GetAllBlogs(this.blogReposistory);
  @override
  Future<Either<Failure, List<Blog>>> call()async {
      return await blogReposistory.getAllBlogs();
  }

  
}