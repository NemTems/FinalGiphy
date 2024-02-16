import 'package:final_giphy/model/gif_model.dart';

class GifList{
  final List<Gif> gifsData;

  GifList({required this.gifsData});

  factory GifList.fromJson(Map<String, dynamic> json){
    final gifs = json['data'] as List<dynamic>;
    final List<Gif> entities = [];

    for(final gif in gifs){
      entities.add(Gif.fromJson(gif as Map<String,dynamic>));
    }

    return GifList(gifsData: entities);
  } 
}