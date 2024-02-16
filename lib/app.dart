import 'package:final_giphy/bloc/gifs_bloc.dart';
import 'package:final_giphy/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => GifsBloc(),
      child: MaterialApp(
        title: 'Gif Searcher',
        theme: ThemeData(primaryColor: const Color.fromARGB(255, 32, 26, 26)),
        debugShowCheckedModeBanner: false,
        initialRoute: Routes.startPage,
        onGenerateRoute: Routes.generateRoute,
      ),
    );
  }
}
