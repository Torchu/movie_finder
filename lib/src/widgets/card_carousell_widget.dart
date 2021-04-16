import 'dart:js';

import 'package:flutter/material.dart';
import 'package:movie_finder/src/models/movie_model.dart';

class CardCarousell extends StatelessWidget {
  final MovieList movies;
  CardCarousell({@required this.movies});

  @override
  Widget build(BuildContext context) {
    final _screenSize = MediaQuery.of(context).size;

    return Container(
      height: _screenSize.height * 0.2,
      child: PageView(
        controller: PageController(
          initialPage: 1,
          viewportFraction: 0.3,
        ),
        pageSnapping: false,
        children: _cards(context),
      ),
    );
  }

  List<Widget> _cards(BuildContext context {
    final _screenSize = MediaQuery.of(context).size;

    return movies.items.map((movie) {
      return Container(
        margin: EdgeInsets.only(right: _screenSize.width * 0.035),
        child: Column(
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.circular(20.0),
              child: FadeInImage(
                placeholder: AssetImage('assets/img/no-image.jpg'),
                image: movie.getPosterImg(),
                fit: BoxFit.cover,
                height: _screenSize.height * 0.175,
              ),
            ),
            Text(
              movie.title,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.caption
            )
          ],
        ),
      );
    }).toList();
  }
}
