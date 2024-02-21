part of 'gifs_bloc.dart';

@immutable
sealed class GifsEvent extends Equatable{
  const GifsEvent();

  @override
  List<Object> get props => [];
}

class TrendingGifsEvent extends GifsEvent{}

class SearchGifsEvent extends GifsEvent{
  final String query;

  const SearchGifsEvent({this.query = ""});

  @override
  List<Object> get props => [query];
}

class FetchMoreGifs extends GifsEvent{}

