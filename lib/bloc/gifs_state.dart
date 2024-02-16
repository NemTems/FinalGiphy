part of 'gifs_bloc.dart';

@immutable
sealed class GifsState extends Equatable{
  const GifsState();

  @override
  List<Object> get props => [];
}

final class GifsInitialState extends GifsState {}

final class GifsLoadingState extends GifsState {}

final class GifsLoadedState extends GifsState {
  final List<Gif> gifs;

  const GifsLoadedState(this.gifs);

  @override
  List<Object> get props => [gifs];
}

final class GifsErrorState extends GifsState {
  final String error;

  const GifsErrorState(this.error);

  @override
  List<Object> get props => [error];
}
