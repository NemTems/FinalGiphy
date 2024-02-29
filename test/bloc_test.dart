import 'package:bloc_test/bloc_test.dart';
import 'package:final_giphy/bloc/gifs_bloc.dart';
import 'package:final_giphy/client/giphy_api.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class MockGiphyClient extends Mock implements GiphyClient{}

  void main(){
    group("GifBloc test", () { 
      late GifsBloc mockBloc;
      late MockGiphyClient mockClient;

      setUp(() {
        mockBloc = GifsBloc();
        mockClient = MockGiphyClient();
      });

      group("States testing", () { 

        test("Initial state", () {
          expect(
            mockBloc.state.status ,
            equals(GifsStatus.initial)
          );
        });

      });
      
    blocTest("Emits TrendingGifs and checks for an empty gif list", // Doesn't work due to the exception: "type 'Null' is not a subtype of type 'Future<List<Gif>>'"
      build:() {
        when(mockClient.fetchGifs())
          .thenAnswer((_) async => []);
        return mockBloc;
      },
      act: (bloc) => bloc.add(TrendingGifsEvent()),
      expect: () => [
      const GifsState(status: GifsStatus.initial),
      const GifsState(
        status: GifsStatus.success,
        gifs: [],
        hasGifs: true,
      ), 
    ],
    );
  });
}
