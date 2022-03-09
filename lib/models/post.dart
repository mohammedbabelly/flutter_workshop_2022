// To parse this JSON data, do
//
//     final post = postFromJson(jsonString);

import 'dart:convert';

class Post {
  Post({
    required this.text,
    required this.interactions,
  });
   late String id;
  final String text;
   int interactions;

  factory Post.fromRawJson(String str) => Post.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Post.fromJson(Map<String, dynamic> json) => Post(
        text: json["text"],
        interactions: json["interactions"],
      );

  Map<String, dynamic> toJson() => {
        "text": text,
        "interactions": interactions,
      };
}
