part of 'gifs_bloc.dart';

enum GifsStatus { initial, success, error }

//No other states were created, since emit of different event updates the whole builder
class GifsState extends Equatable { 
  final GifsStatus status;
  final List<Gif> gifs;
  final bool hasGifs;
  final String errorMessage;

  const GifsState({
    this.status = GifsStatus.initial,
    this.gifs = const [],
    this.hasGifs = true,
    this.errorMessage = "",
  });

  GifsState initializeGifs(List<Gif> gifs) {
    return GifsState(
      status: GifsStatus.initial,
      hasGifs: hasGifs,
      errorMessage: errorMessage,
      gifs: gifs,
    );
  }

  GifsState copyWith({
    GifsStatus? status,
    List<Gif>? gifs,
    bool? hasGifs,
    String? errorMessage,
  }) {
    return GifsState(
      status: status ?? this.status,
      gifs: gifs ?? this.gifs,
      hasGifs: hasGifs ?? this.hasGifs,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [status, gifs, hasGifs, errorMessage];
}

