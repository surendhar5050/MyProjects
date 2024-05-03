part of 'blog_bloc.dart';

sealed class BlogState extends Equatable {
  const BlogState();

  @override
  List<Object> get props => [];
}

final class BlogInitial extends BlogState {}

final class BlogLoading extends BlogState {}

final class BlogUploadSucess extends BlogState {}

final class BlogDisplaySucess extends BlogState {
  final List<Blog> blogs;

  const BlogDisplaySucess({required this.blogs});
}

final class BlogFailure extends BlogState {
  final String error;

  const BlogFailure(this.error);
}
