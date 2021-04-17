import 'package:flutter/material.dart';
import 'package:movie_finder/src/models/movie_model.dart';

class MovieDetails extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Movie movie = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      body: Center(
        child: Text(movie.title),
      ),
    );
  }
}
