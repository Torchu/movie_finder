import 'package:flutter/material.dart';
import 'package:movie_finder/src/models/movie_model.dart';
import 'package:movie_finder/src/providers/movies_provider.dart';
import 'package:movie_finder/src/widgets/card_carousell_widget.dart';
import 'package:movie_finder/src/widgets/card_swiper_widget.dart';

class HomePage extends StatelessWidget {
  final movieProvider = new MovieProvider();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Trending movies'),
          centerTitle: false,
          backgroundColor: Colors.red.shade900,
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
    movieProvider.getPopular();
    return Container(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
              padding: EdgeInsets.only(
                  left: MediaQuery.of(context).size.width * 0.04),
              child: Text('Trending movies',
                  style: Theme.of(context).textTheme.subtitle1)),
          SizedBox(height: MediaQuery.of(context).size.height * 0.005),
          StreamBuilder(
            stream: movieProvider.popularStream,
            builder: (BuildContext context, AsyncSnapshot<MovieList> snapshot) {
              return snapshot.hasData
                  ? CardCarousell(
                    movies: snapshot.data,
                    nextPage: movieProvider.getPopular
                  )
                  : Container(
                      height: MediaQuery.of(context).size.height * 0.2,
                      child: Center(child: CircularProgressIndicator()));
            },
          ),
        ],
      ),
    );
  }
}
