import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:final_giphy/client/giphy_api.dart';
import 'package:final_giphy/model/gif_model.dart';
import 'package:flutter/foundation.dart';
import 'package:meta/meta.dart';

part 'gifs_event.dart';
part 'gifs_state.dart';

class GifsBloc extends Bloc<GifsEvent, GifsState> {
  final GiphyClient giphyClient = GiphyClient();
  String currentQuery = "";

  GifsBloc() : super(const GifsState()) {

    on<GifsEvent>((event, emit) async {
      if (event is TrendingGifsEvent) { // Initializing of first 50 trending gifs
      emit(state.copyWith(status: GifsStatus.initial)); // To set the app to the loading state and move the user to the top of the app
        try {
          currentQuery = "";
          final newGifs = await giphyClient.fetchGifs();
          return newGifs.isEmpty // return messege "No gifs found" / return gif list 
              ? emit(state.copyWith(hasGifs: false, status: GifsStatus.success))
              : emit(state.copyWith(
                  status: GifsStatus.success,
                  gifs: newGifs,
                  hasGifs: true));
        } catch (e) {
          emit(state.copyWith(
              status: GifsStatus.error,
              errorMessage: "Failed to fetch Trending Gifs: $e"));
        }
      } else if(event is SearchGifsEvent) { // SearchGifs event processing (Has the same structure as TrendingGifs)
        emit(state.copyWith(status: GifsStatus.initial));
        try {
          currentQuery = event.query;
            final newGifs = await giphyClient.fetchGifs(query: event.query);
            return newGifs.isEmpty 
                ? emit(state.copyWith(hasGifs: false, status: GifsStatus.success))
                : emit(state.copyWith(
                    status: GifsStatus.success,
                    gifs: newGifs,
                    hasGifs: true));
        } catch (e) {
          emit(state.copyWith(
              status: GifsStatus.error,
              errorMessage: "Failed to Search Gifs: $e"));
        }
      }
      else if(event is FetchMoreGifs){ // when user almost reaches the last gif, this event is called 
        try{
          if(currentQuery.isEmpty){
            final newGifs =
            await giphyClient.fetchGifs(offset: state.gifs.length);
            emit(state.copyWith(
              status: GifsStatus.success,
              gifs: List.of(state.gifs)..addAll(newGifs),
              hasGifs: true));
          }
          else if (currentQuery.isNotEmpty){
            final newGifs = await giphyClient.fetchGifs(
            query: currentQuery,
            offset: state.gifs.length
            );
            emit(state.copyWith(
              status: GifsStatus.success,
              gifs: List.of(state.gifs)..addAll(newGifs),
              hasGifs: true));
          }
        }catch(e){
          emit(state.copyWith(
            status: GifsStatus.error,
            errorMessage: "Failed to Search Gifs: $e"));
        }
      }
    });
  }
}