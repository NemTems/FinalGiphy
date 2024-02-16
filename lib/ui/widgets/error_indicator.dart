import 'package:flutter/material.dart';

class GifErrorWidget extends StatelessWidget {
  const GifErrorWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Icon(
        Icons.error,
        color: Colors.red,
      ),
    );
  }
}