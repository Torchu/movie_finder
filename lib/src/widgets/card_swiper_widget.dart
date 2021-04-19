import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:movie_finder/src/models/movie_model.dart';

class CardSwiper extends StatelessWidget {
  final MovieList movies;
  CardSwiper({@required this.movies});

  @override
  Widget build(BuildContext context) {
    final _screenSize = MediaQuery.of(context).size;

    return Container(
      padding: EdgeInsets.only(top: _screenSize.height * 0.01),
      child: Swiper(
        layout: SwiperLayout.STACK,
        itemWidth: _screenSize.width * 0.7,
        itemHeight: _screenSize.height * 0.5,
        itemBuilder: (context, i) => _card(context, movies.items[i]),
        itemCount: movies.total,
      ),
    );
  }

  Widget _card(BuildContext context, Movie movie) {
    final card = ClipRRect(
      borderRadius: BorderRadius.circular(20.0),
      child: FadeInImage(
        image: movie.getPosterImg(),
        placeholder: AssetImage('assets/img/no-image.jpg'),
        fit: BoxFit.cover,
      )
    );

    return GestureDetector(
      child: card,
      onTap: () {
        Navigator.pushNamed(context, 'details', arguments: movie);
      },
    );
  }
}
