# Gif application//Task//Chililabs

Flutter version: 3.10.6
Dart version: 3.0.6

# Comments and Questions to the reviewers
* Initially, the project was built based on several application states, for example, GifLoadingState, GifLoadedState, GifInitialState, etc. Each of them was called based on the corresponding event. But later it turned out that changing the state leads to the entire builder being completely rebuilt, which interferes with the work of "infinite scroll". I had to redo the applications to work more correctly. But I have a question, was it possible to handle this situation without changing the existing states of the program?
* I took inspiration and knowledge from many sources, but what helped me most was the example from the official Bloc website, where, although with an old version, they show the structure of building such an application. (Link: https://bloclibrary.dev/#/flutterinfinitelisttutorial)

# Problems
* I have created routes.dart file, that handles route forwarding, but GifDetailedScreen needed to pass gif as an argument, and for some reason, through the Navigator.pushNamed with passing arguments it didn't work. For this reason, I had to make this route 'special', the redirection to which is not in the routes.dart.
* Unit testing came out very mediocre, and not all of it. The main problem was in creating mocks and using them, the mock of GiphyClient I created couldn't function normally, constantly showing 1 error(You can check it in the bloc_test.dart). I've watched many videos and materials, but still can’t understand how to fix it.