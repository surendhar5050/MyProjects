import 'dart:async';
import 'dart:io';

import 'package:blogapp/features/blog/domain/entites/blog.dart';
import 'package:blogapp/features/blog/domain/usescase/getall_blog.dart';
import 'package:blogapp/features/blog/domain/usescase/upload_blog.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'blog_event.dart';
part 'blog_state.dart';

class BlogBloc extends Bloc<BlogEvent, BlogState> {
  final UploadBlog _upLoadBlog;
  final GetAllBlogs _getAllBlogs;

  BlogBloc({required UploadBlog upLoadBlog, required GetAllBlogs getAllBlogs})
      : _upLoadBlog = upLoadBlog,
        _getAllBlogs = getAllBlogs,
        super(BlogInitial()) {
    on<BlogEvent>((event, emit) => emit(BlogLoading()));
    on<BlogUpLoadEvent>(blogUpLoadEvent);
    on<GetAllBlogsEvent>(getAllBlogsEvent);
  }

  FutureOr<void> blogUpLoadEvent(
    BlogUpLoadEvent event,
    Emitter<BlogState> emit,
  ) async {
    final res = await _upLoadBlog(UploadBlogParams(
      titile: event.titile,
      content: event.content,
      image: event.image,
      topics: event.topics,
    ));

    res.fold(
      (failure) => emit(BlogFailure(failure.message)),
      (blog) => emit(BlogUploadSucess()),
    );
  }

  FutureOr<void> getAllBlogsEvent(
    GetAllBlogsEvent event,
    Emitter<BlogState> emit,
  ) async {
    final res = await _getAllBlogs.call();
    res.fold((failure) => emit(BlogFailure(failure.message)),
        (blogs) => emit(BlogDisplaySucess(blogs: blogs)));
  }
}
