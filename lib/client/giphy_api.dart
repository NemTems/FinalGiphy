import 'dart:convert';

import 'package:final_giphy/model/gif_model.dart';
import 'package:final_giphy/model/gifs_list_model.dart';
import 'package:http/http.dart' as http;

class GiphyClient{
  static const String mainUrl = 'https://api.giphy.com/v1/gifs';
  static const String apiKey = 'Pyoqvh7L7elrqaYVAeqBnhO1KqMpd8gy';
  
  Future<List<Gif>> fetchGifs({String query = "",int offset = 0}) async{
    if(query.isEmpty){ // fetch trending gifs
      final response = await http.get(
      Uri.parse('$mainUrl/trending?api_key=$apiKey&offset=$offset')
      );
      if (response.statusCode == 200) {
        final Map<String, dynamic> data = jsonDecode(response.body);
        final GifList gifList = GifList.fromJson(data);
        return gifList.gifsData;
      } else {
        throw Exception('Failed to fetch trending gifs');
      }
    }
    else{ // fetch gifs by query (SearchGifs)
      final response = await http.get(
        Uri.parse('$mainUrl/search?api_key=$apiKey&q=$query&offset=$offset')
      );
      if (response.statusCode == 200) {
        final Map<String, dynamic> data = jsonDecode(response.body);
        final GifList gifList = GifList.fromJson(data);
        return gifList.gifsData;
      } else {
        throw Exception('Failed to fetch gifs');
      }
    }
  }
}