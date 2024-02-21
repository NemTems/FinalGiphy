import 'package:final_giphy/bloc/gifs_bloc.dart';
import 'package:final_giphy/ui/widgets/gif_tile.dart';
import 'package:final_giphy/ui/widgets/search_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController searchController = TextEditingController();

  TextStyle errorStyle = const TextStyle(color: Colors.white, fontSize: 20);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => GifsBloc()..add(TrendingGifsEvent()), // app started -> trending gifs loaded
      child: Scaffold(
        appBar: SearchAppBar(
          appBar: AppBar(),
        ),
        backgroundColor: Colors.black,
        body: BlocBuilder<GifsBloc, GifsState>(
          builder: (context, state) {
            if (state.status == GifsStatus.initial) { 
              return const Center(child: CircularProgressIndicator());
            }
            if (state.status == GifsStatus.success) {
              return OrientationBuilder(builder: (context, orientation) {
                if (state.hasGifs) {
                  return GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount:
                        orientation == Orientation.portrait ? 2 : 3,
                      crossAxisSpacing: 0,
                    ),
                    itemBuilder: (context, index) {
                      if (index == state.gifs.length - 10 && state.hasGifs)  {
                        context.read<GifsBloc>().add(FetchMoreGifs());
                      }
                      print(index);

                      return GifTile(gif: state.gifs[index]);
                    },
                    itemCount: state.gifs.length,
                  );
                } else {
                  return Center(
                  child: Text("No gifs for a current query", style: errorStyle));
                }
              });
            }
            if (state.status == GifsStatus.error) {
              return Center(
                  child: Text(
                'Error: ${state.errorMessage}',
                style: errorStyle,
              ));
            }
            return Container(); // return empty container by default
          },
        ),
      ),
    );
  }
}
