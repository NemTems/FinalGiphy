import 'package:flutter/material.dart';
import 'package:final_giphy/ui/screen/start_page.dart';
import 'package:final_giphy/ui/screen/search_screen.dart';

class Routes {
  static const String startPage = '/start_page';
  static const String gifSearch = '/gif_search';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case startPage:
        return createRoute(const StartPage());
      case gifSearch:
        return createRoute(const SearchScreen());
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(
              child: Text('Unknown route: ${settings.name}'),
            ),
          ),
        );
    }
  }

  static Route createRoute(Widget page) { // Animation for route navigation
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => page,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(1.0, 0.0);
        const end = Offset.zero;
        const curve = Curves.ease;

        var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      },
    );
  }
}
