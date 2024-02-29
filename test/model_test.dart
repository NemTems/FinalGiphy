
import 'package:final_giphy/model/gif_model.dart';
import 'package:final_giphy/model/gifs_list_model.dart';
import 'package:final_giphy/model/image_model.dart';
import 'package:flutter_test/flutter_test.dart';

main(){
  group('All model testing', () { 
    final Map<String,dynamic> data = 
      {
        "data":[
          {
            "id": "1234",
            "url": "https://gif_example.com",
            "title": "Cool Gif example",
            "images": {
              "preview_gif":{
                "url": "https://preview_example.com",
                "width":"100",
                "height": "100",
              },
              "original":{
                "url": "https://original_example.com",
                "width":"500",
                "height": "500"
              },
            },
          }
        ],
      };

      test("ImageBase fromJson and equatable test", () {
        final imageBase = ImageBase.fromJson(data
        ["data"][0]["images"]["preview_gif"]);
        
        const imageMatcher =  ImageBase(
          url: "https://preview_example.com",
          width: "100", 
          height: "100");
      
        expect(imageBase, imageMatcher);
      });

      test("GifsImage fromJson and equatable test", () {
        final gifsImages = GifsImages.fromJson(data
        ["data"][0]["images"]);
        final smallImage = ImageBase.fromJson(data
        ["data"][0]["images"]["preview_gif"]);
        final detailedImage = ImageBase.fromJson(data
        ["data"][0]["images"]["original"]);

        final gifsImagesMatcher =  GifsImages(
          smallImage: smallImage,
          detailedImage: detailedImage,
        );
      
        expect(gifsImages, gifsImagesMatcher);
      });

      test("Gif fromJson and equatable test", () {
        final gif = Gif.fromJson(data["data"][0]);
        final gifsImages = GifsImages.fromJson(data
        ["data"][0]["images"]);
        
        final gifMatcher =  Gif(
          id: "1234", 
          url: "https://gif_example.com", 
          title: "Cool Gif example", 
          images: gifsImages);
      
        expect(gif, gifMatcher);
      });

      test("GifsList fromJson and equatable test", () {
        final gifList = GifList.fromJson(data);
        final gif = Gif.fromJson(data["data"][0]);
        
        final gifListMatcher =  GifList(gifsData: [gif]);
      
        expect(gifList, gifListMatcher);
      });      
  });
}