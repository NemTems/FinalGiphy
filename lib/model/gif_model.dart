import 'package:final_giphy/model/image_model.dart';

class Gif{
  final String id;
  final String url;
  final String title;
  final GifsImages images;

  Gif({
    required this.id,
    required this.url,
    required this.title,
    required this.images,
  });

  factory Gif.fromJson(Map<String, dynamic> json) => Gif(
    id: json['id'] as String,
    url: json['url'] as String,
    title: json['title'] as String,
    images: GifsImages.fromJson(json['images'] as Map<String, dynamic>)
  );
}