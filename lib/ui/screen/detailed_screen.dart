import 'package:final_giphy/model/gif_model.dart';
import 'package:flutter/material.dart';

class GifDetailedScreen extends StatelessWidget {
  const GifDetailedScreen({Key? key, required this.gif}) : super(key: key);
  final Gif gif;

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;

    Color subColor = const Color.fromARGB(255, 125, 125, 125);
    Color appBarColor = const Color.fromARGB(255, 32, 26, 26);

    TextStyle headingStyle = const TextStyle(
      fontSize: 24,
      color: Colors.black,
      fontWeight: FontWeight.bold,
    );
    TextStyle subtitleStyle = const TextStyle(
      fontSize: 14,
      color: Colors.black,
    );

    return Scaffold(
      appBar: AppBar(
        leadingWidth: 25,
        centerTitle: true,
        title: Text('Details',style: TextStyle(color: subColor),), 
        backgroundColor: appBarColor,
        iconTheme: IconThemeData(color: subColor),
      ),
      body: SingleChildScrollView( // Was made to get rid of overflow
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              children: [         
                Text(gif.title, style: headingStyle, textAlign: TextAlign.center),
                const SizedBox(height: 20),
                Image.network( // Original image 
                  gif.images.detailedImage.url!,
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
                  },
                ),
                const SizedBox(height: 20,),
                Container( // Bottom description container

                  color: Colors.white,
                  child: Column(
                    children: [
                      Text(
                        "This is your's desired gif",
                        style: subtitleStyle,
                        textAlign: TextAlign.center,
                      ),
                      Text(
                        "Enjoy",
                        style: subtitleStyle.copyWith(fontWeight: FontWeight.bold,),
                        textAlign: TextAlign.center
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
