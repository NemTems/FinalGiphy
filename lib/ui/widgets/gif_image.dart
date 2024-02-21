
import 'package:final_giphy/model/gif_model.dart';
import 'package:final_giphy/ui/widgets/error_indicator.dart';
import 'package:flutter/material.dart';

class GifImageWidget extends StatelessWidget {
  const GifImageWidget({super.key, required this.gif});

  final Gif gif;
  
  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;

    return Image.network(
      gif.images.smallImage.url!,
      height: screenSize.height,
      width: screenSize.width,
      fit: BoxFit.fitHeight,

      errorBuilder: (BuildContext context, Object error, StackTrace? stackTrace){
        return const GifErrorWidget();
      },
      loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent? loadingProcces){
        if(loadingProcces == null){
          return child;
        }
        else{ 
          return Center(
            child: CircularProgressIndicator(
              value: loadingProcces.expectedTotalBytes != null
                ? loadingProcces.cumulativeBytesLoaded/(loadingProcces.expectedTotalBytes ?? 1)
                : null,
            ),
          );
        }
      },);
  }
}