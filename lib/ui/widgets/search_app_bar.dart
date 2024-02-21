import 'dart:async';

import 'package:final_giphy/bloc/gifs_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchAppBar extends StatelessWidget implements PreferredSizeWidget {
  final TextEditingController searchController = TextEditingController();
  final AppBar appBar;

  SearchAppBar({Key? key, required this.appBar}) : super(key: key);

  @override
  Size get preferredSize => Size.fromHeight(appBar.preferredSize.height);

  @override
  Widget build(BuildContext context) {
  Color mainColor = const Color.fromARGB(255, 125, 125, 125);
  Color backgroundColor = const Color.fromARGB(255, 7, 7, 7);
  Color appBarColor = const Color.fromARGB(255, 32, 26, 26);

  Timer queryTimer = Timer(Duration.zero, () { });

    return AppBar(
      centerTitle: true,
      leadingWidth: 25,
      iconTheme: IconThemeData(color: mainColor),
      elevation: 0,
      backgroundColor: appBarColor,
      title: Container(
        width: double.infinity,
        height: 40, 
         decoration: BoxDecoration(
            color: backgroundColor,
          borderRadius: BorderRadius.circular(20),
        ),
      child: Padding(
        padding: const EdgeInsets.only(left: 15, right: 4),
        child: TextField(
          textAlignVertical: const TextAlignVertical(y: -0.35),
          style: TextStyle(
            fontSize: 18,
            color: mainColor,
          ),
          controller: searchController,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.zero,
            suffixIcon: const Icon(Icons.search ),
            suffixIconColor: mainColor,
            hintText: 'Search Gifs',
            hintStyle: TextStyle(
              color: mainColor,
            ),
            border: InputBorder.none,
          ),
          onChanged: (query) { //Initialize new gifs according to the query
            queryTimer.cancel();
            queryTimer = Timer(const Duration(milliseconds: 400), ()async  {
              context.read<GifsBloc>().add(SearchGifsEvent(query: query));
            });
          },
        ),
      ),
      ),
    );
  }
}
