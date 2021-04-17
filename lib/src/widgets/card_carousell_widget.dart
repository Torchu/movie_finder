import 'package:flutter/material.dart';
import 'package:movie_finder/src/models/movie_model.dart';

class CardCarousell extends StatelessWidget {
  final MovieList movies;
  final Function nextPage;
  CardCarousell({@required this.movies, @required this.nextPage});

  final _pageController =
      new PageController(initialPage: 1, viewportFraction: 0.3);

  @override
  Widget build(BuildContext context) {
    final _screenSize = MediaQuery.of(context).size;
    _pageController.addListener(() {
      if (_pageController.position.pixels >=
          _pageController.position.maxScrollExtent - _screenSize.width * 0.5) {
        nextPage();
      }
    });

    return Container(
      height: _screenSize.height * 0.2,
      child: PageView(
        controller: _pageController,
        pageSnapping: false,
        children: _cards(context),
      ),
    );
  }

  List<Widget> _cards(BuildContext context) {
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
            Text(movie.title,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.caption)
          ],
        ),
      );
    }).toList();
  }
}
