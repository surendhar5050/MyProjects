part of 'blog_bloc.dart';

sealed class BlogEvent extends Equatable {
  const BlogEvent();

  @override
  List<Object> get props => [];
}

final class BlogUpLoadEvent extends BlogEvent {
  final String titile;
  final String content;
  final File image;
  final List<String> topics;

  const BlogUpLoadEvent({
    required this.titile,
    required this.content,
    required this.image,
    required this.topics,
  });
}

final class GetAllBlogsEvent extends BlogEvent {
  const GetAllBlogsEvent();
}
