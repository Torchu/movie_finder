import 'package:flutter/material.dart';
import 'package:movie_finder/src/models/movie_model.dart';

class MovieDetails extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Movie movie = ModalRoute.of(context).settings.arguments;
    final _screenSize = MediaQuery.of(context).size;

    return Scaffold(
        body: CustomScrollView(
      slivers: <Widget>[
        _createAppBar(movie, _screenSize),
        SliverList(
          delegate: SliverChildListDelegate([
            SizedBox(height: _screenSize.height * 0.01),
            _createMovieTitle(movie, context, _screenSize),
            _createMovieDescription(movie)
          ]),
        )
      ],
    ));
  }

  Widget _createAppBar(Movie movie, Size screenSize) {
    return SliverAppBar(
      elevation: 2.0,
      backgroundColor: Colors.red.shade900,
      expandedHeight: screenSize.height * 0.2,
      floating: false,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        title: Text(
          movie.title,
          style: TextStyle(color: Colors.white, fontSize: 16.0),
        ),
        background: FadeInImage(
          image: movie.getBackdropImg(),
          placeholder: AssetImage('assets/img/loading.gif'),
          fadeInDuration: Duration(milliseconds: 150),
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget _createMovieTitle(Movie movie, BuildContext context, Size screenSize) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: screenSize.width * 0.05),
      child: Row(
        children: <Widget>[
          ClipRRect(
            borderRadius: BorderRadius.circular(20.0),
            child: Image(
                image: movie.getPosterImg(), height: screenSize.height * 0.16),
          ),
          SizedBox(width: screenSize.width * 0.05),
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(movie.title,
                    style: Theme.of(context).textTheme.headline6,
                    overflow: TextOverflow.ellipsis),
                Text(movie.originalTitle,
                    style: Theme.of(context).textTheme.subtitle1,
                    overflow: TextOverflow.ellipsis),
                Row(
                  children: <Widget>[
                    Icon(Icons.star_border),
                    Text(movie.voteAverage.toString(),
                        style: Theme.of(context).textTheme.subtitle1)
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _createMovieDescription(Movie movie) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
      child: Text(
        movie.overview,
        textAlign: TextAlign.justify,
      ),
    );
  }
}
