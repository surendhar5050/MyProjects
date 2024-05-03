import 'package:blogapp/core/theme/app_pallete.dart';
import 'package:blogapp/core/utils/calculation_reading.dart';
import 'package:blogapp/core/utils/format_date.dart';
import 'package:blogapp/features/blog/domain/entites/blog.dart';
import 'package:flutter/material.dart';

class BlogViewerPage extends StatelessWidget {
  static route(Blog blog) => MaterialPageRoute(
        builder: (context) => BlogViewerPage(blog: blog),
      );

  final Blog blog;
  const BlogViewerPage({super.key, required this.blog});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Scrollbar(
          
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  blog.titile,
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  "By ${blog.posterName}",
                  style: const TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  '${formatDateBydMMMYYYY(blog.updateAt)} . ${calculatereadingTime(blog.content)} min',
                  style: const TextStyle(
                    color: AppPallete.greyColor,
                    fontWeight: FontWeight.w500,
                    fontSize: 16,
                  ),
                ),
                 const SizedBox(
                  height: 20,
                ),
          
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.network(blog.imageUrl),
              ),
          
                   const SizedBox(
                  height: 20,
                ),
          
                 Text(
                  blog.content,
                  style: const TextStyle(
                    height: 2,
                    color: AppPallete.greyColor,
                    fontWeight: FontWeight.w500,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
