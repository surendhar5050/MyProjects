// ignore_for_file: public_member_api_docs, sort_constructors_first


class Blog  {
  final String id;
  final String titile;
  final String content;
  final String imageUrl;
  final List<String> topics;
  final DateTime updateAt;
  final String? posterName;

  Blog({
    required this.id,
    required this.titile,
    required this.content,
    required this.imageUrl,
    required this.topics,
    required this.updateAt,
    required this.posterName
  });



 
}
