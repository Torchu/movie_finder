import 'package:flutter/material.dart';
import 'package:movie_finder/src/models/movie_model.dart';
import 'package:movie_finder/src/providers/movies_provider.dart';
import 'package:movie_finder/src/widgets/card_swiper_widget.dart';

class HomePage extends StatelessWidget {
  final movieProvider = new MovieProvider();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Trending movies'),
          centerTitle: false,
          backgroundColor: Colors.indigoAccent,
          actions: <Widget>[
            IconButton(icon: Icon(Icons.search), onPressed: () {})
          ],
        ),
        body: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[_movieCards(), _footer(context)],
          ),
        ));
  }

  Widget _movieCards() {
    return FutureBuilder(
      future: movieProvider.getNowPlaying(),
      builder: (BuildContext context, AsyncSnapshot<MovieList> snapshot) {
        return snapshot.hasData
            ? CardSwiper(movies: snapshot.data)
            : Container(
                height: MediaQuery.of(context).size.height * 0.5,
                child: Center(child: CircularProgressIndicator()));
      },
    );
  }

  Widget _footer(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Column(
        children: <Widget>[
          Text('Trending', style: Theme.of(context).textTheme.subtitle1),
          FutureBuilder(
            future: movieProvider.getPopular(),
            builder: (BuildContext context, AsyncSnapshot<MovieList> snapshot) {
              return snapshot.hasData
                  ? CardSwiper(movies: snapshot.data)
                  : Container(
                      height: MediaQuery.of(context).size.height * 0.5,
                      child: Center(child: CircularProgressIndicator())
                    );
            },
          ),
        ],
      ),
    );
  }
}
