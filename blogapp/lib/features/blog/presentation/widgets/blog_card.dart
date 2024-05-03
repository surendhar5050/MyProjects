import 'package:blogapp/core/utils/calculation_reading.dart';
import 'package:blogapp/features/blog/domain/entites/blog.dart';
import 'package:blogapp/features/blog/presentation/pages/blog_viewer_page.dart';
import 'package:flutter/material.dart';

class BlogCard extends StatelessWidget {
  final Blog blog;
  final Color cardColor;
  const BlogCard({super.key, required this.blog, required this.cardColor});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context, BlogViewerPage.route(blog));
      },
      child: Container(
        padding: const EdgeInsets.all(16.0).copyWith(bottom: 4),
        margin: const EdgeInsets.all(16.0).copyWith(bottom: 4),
        decoration: BoxDecoration(
            color: cardColor, borderRadius: BorderRadius.circular(10)),
        height: 200,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: blog.topics
                        .map((e) => Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 5),
                              child: Chip(label: Text(e)),
                            ))
                        .toList(),
                  ),
                ),
                Text(
                  blog.titile,
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
             Text('${calculatereadingTime(blog.content)} min')
          ],
        ),
      ),
    );
  }
}
