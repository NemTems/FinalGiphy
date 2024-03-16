# Gif application

Flutter version: 3.10.6
Dart version: 3.0.6

# Problems
* I have created routes.dart file, that handles route forwarding, but GifDetailedScreen needed to pass gif as an argument, and for some reason, through the Navigator.pushNamed with passing arguments it didn't work. For this reason, I had to make this route 'special', the redirection to which is not in the routes.dart.
* Unit testing came out very mediocre, and not all of it. The main problem was in creating mocks and using them, the mock of GiphyClient I created couldn't function normally, constantly showing 1 error(You can check it in the bloc_test.dart). I've watched many videos and materials, but still can’t understand how to fix it.
