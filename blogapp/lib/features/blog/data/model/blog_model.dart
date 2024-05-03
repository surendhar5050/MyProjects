import 'package:blogapp/features/blog/domain/entites/blog.dart';

class BlogModel extends Blog {
  BlogModel({
    required super.id,
    required super.titile,
    required super.content,
    required super.imageUrl,
    required super.topics,
    required super.updateAt,
     super.posterName
  });



  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'titile': titile,
      'content': content,
      'imageUrl': imageUrl,
      'topics': topics,
      'updateAt': updateAt.toIso8601String(),
    };
  }

  factory BlogModel.fromMap(Map<String, dynamic> map) {
    return BlogModel(
      id: map['id'] as String,
      titile: map['titile'] as String,
      content: map['content'] as String,
      imageUrl: map['imageUrl'] as String,
      topics: List<String>.from(map['topics'] ),
      updateAt:DateTime.parse(map['updateAt']??DateTime.now()),
      
    );
  }

   BlogModel copyWith({
    String? id,
    String? posterId,
    String? titile,
    String? content,
    String? imageUrl,
    List<String>? topics,
    DateTime? updateAt,
    String ? posterName
  }) {
    return BlogModel(
      id: id ?? this.id,
      titile: titile ?? this.titile,
      content: content ?? this.content,
      imageUrl: imageUrl ?? this.imageUrl,
      topics: topics ?? this.topics,
      updateAt: updateAt ?? this.updateAt,
      posterName: posterName?? this.posterName
    );
  }
}
