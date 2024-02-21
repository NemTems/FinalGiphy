  import 'package:final_giphy/bloc/gifs_bloc.dart';
  import 'package:final_giphy/model/gif_model.dart';
import 'package:final_giphy/ui/screen/detailed_screen.dart';
  import 'package:final_giphy/ui/widgets/error_indicator.dart';
  import 'package:final_giphy/ui/widgets/gif_image.dart';
  import 'package:flutter/material.dart';
  import 'package:flutter_bloc/flutter_bloc.dart';

  class GifTile extends StatelessWidget {
    const GifTile({super.key, required this.gif});
    final Gif gif;

    @override
    Widget build(BuildContext context) {
      return BlocBuilder<GifsBloc, GifsState>(
        builder: (context, state) {
          return Center(
            child: InkWell(
              onTap: () => {
                Navigator.push(context, MaterialPageRoute(
                  builder: (context) => GifDetailedScreen(gif: gif)
                )),
              },
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: const Color.fromARGB(255, 0, 0, 0),
                    width: 3,
                    strokeAlign: BorderSide.strokeAlignCenter, 
                  ),
                ),
                child: state.status == GifsStatus.error
                  ? const GifErrorWidget()
                  : GifImageWidget(gif: gif),
              ),
            ),
        );
      },
    );
  }
}