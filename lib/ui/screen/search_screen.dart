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
  final scrollController = ScrollController();
  
  double scrollOffset = 0;


  TextStyle errorStyle = const TextStyle(
    color: Colors.white,
    fontSize: 20
    );

  @override
  void initState(){
    super.initState();
    BlocProvider.of<GifsBloc>(context).add(TrendingGifsEvent());  
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SearchAppBar(appBar: AppBar(),),
      backgroundColor: Colors.black,
      body: BlocBuilder<GifsBloc, GifsState>(
        builder: (context, state) {
          if (state is GifsInitialState) {
            return const Center(child: Text('Enter a search query'));
          } else if (state is GifsLoadingState) {
              return const Center(child: CircularProgressIndicator());
          } else if (state is GifsLoadedState) {
              return OrientationBuilder(
                builder: (context, orientation){
                if(state.gifs.isNotEmpty){
                  return GridView.builder(
                    controller: scrollController,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 
                      orientation == Orientation.portrait 
                      ? 2
                      : 3,
                      crossAxisSpacing: 0,
                    ),
                    itemCount: state.gifs.length,
                    itemBuilder: (context, index) { 
                      if(index == state.gifs.length-10){
                        scrollOffset = scrollController.position.maxScrollExtent;
                        context.read<GifsBloc>().add(ScrollDownEvent());
                        scrollController.jumpTo(scrollOffset);
                      }
                      print(index);
                      final gif = state.gifs[index];
                      return GifTile(gif: gif);
                    },
                  );
                }
                else{
                  return Center(
                    child: Text(
                      "No gifs for a current query",
                      style: errorStyle
                    )
                  );
                }
              }
            );
          } else if (state is GifsErrorState) {
            return Center(child: Text('Error: ${state.error}', style: errorStyle,));
          }
          return Container(); // return empty container by default
        },
      ),
    );
  }
}