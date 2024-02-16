import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:final_giphy/client/giphy_api.dart';
import 'package:final_giphy/model/gif_model.dart';
import 'package:meta/meta.dart';

part 'gifs_event.dart';
part 'gifs_state.dart';

class GifsBloc extends Bloc<GifsEvent, GifsState> {
  final GiphyClient giphyClient = GiphyClient();


  GifsBloc() : super(GifsInitialState()) {
  List<Gif> gifs = [];
  int offset = 0;
  String currentQuery = '';

    on<TrendingGifsEvent>((event, emit) async {
      emit(GifsLoadingState());
      try {
        gifs = [];
        offset = 0;

        List<Gif> newGifs = await giphyClient.fetchTrendingGifs();
        gifs.addAll(newGifs); 

        emit(GifsLoadedState(gifs));
      } catch (e) {
        emit(GifsErrorState('Failed to load gifs: $e'));
      }
    });

    on<ScrollDownEvent>((event,emit) async{
      emit(GifsLoadingState());
      try{
        offset = gifs.length;
        if(currentQuery.isEmpty){ //Add more of trending gifs 
          List<Gif> newGifs = await giphyClient.fetchTrendingGifs(offset);
          gifs.addAll(newGifs);
        }
        else{ //Add more of search by query gifs
          List<Gif> newGifs = await giphyClient.searchGifs(currentQuery,offset);
          gifs.addAll(newGifs);
          
        }
        emit(GifsLoadedState(gifs));
      } catch (e){
        emit(GifsErrorState('Failed to add more gifs: $e'));
      }

    });
    on<SearchGifsEvent>((event, emit) async {
      emit(GifsLoadingState());
      try {
        gifs = [];
        offset = 0;
      
        List<Gif> newGifs = await giphyClient.searchGifs(event.query);
        gifs.addAll(newGifs);
        
        currentQuery = event.query;
        emit(GifsLoadedState(gifs));
      } catch (e) {
        emit(GifsErrorState('Failed to search gifs: $e'));
      }
    });
  }
}
