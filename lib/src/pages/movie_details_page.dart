import 'package:flutter/material.dart';
import 'package:movie_finder/src/models/actors_model.dart';
import 'package:movie_finder/src/models/movie_model.dart';
import 'package:movie_finder/src/providers/movies_provider.dart';

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
              _createMovieDescription(movie, _screenSize),
              _createMovieCasting(movie, _screenSize, context)
            ]),
          )
        ],
      )
    );
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
          Hero(
            tag: movie.tagId,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20.0),
              child: Image(
                  image: movie.getPosterImg(), height: screenSize.height * 0.16),
            ),
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

  Widget _createMovieDescription(Movie movie, Size screenSize) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: screenSize.height * 0.01,
        vertical: screenSize.width * 0.05
      ),
      child: Text(
        movie.overview,
        textAlign: TextAlign.justify,
      ),
    );
  }

  Widget _createMovieCasting(Movie movie, Size screenSize, BuildContext context) {
    final movieProvider = new MovieProvider();

    return FutureBuilder(
      future: movieProvider.getCast(movie.id),
      builder: (BuildContext context, AsyncSnapshot<ActorList> snapshot) {
        return snapshot.hasData
            ? _createActorsPageView(snapshot.data, screenSize, context)
            : Container(
                height: screenSize.height * 0.5,
                child: Center(child: CircularProgressIndicator()));
      },
    );
  }

  Widget _createActorsPageView(ActorList cast, Size screensize, BuildContext context) {
    return SizedBox(
      height: screensize.height * 0.2,
      child: PageView.builder(
        pageSnapping: false,
        itemCount: cast.total,
        controller: PageController(viewportFraction: 0.3, initialPage: 1),
        itemBuilder: (context, i) => _createActorCard(cast.items[i], screensize, context)
      ),
    );
  }

  Widget _createActorCard(Actor actor, Size screenSize, BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          ClipRRect(
            borderRadius: BorderRadius.circular(20.0),
            child: FadeInImage(
              image: actor.getProfileImg(),
              placeholder: AssetImage('assets/img/no-image.jpg'),
              fit: BoxFit.cover,
              height: screenSize.height * 0.15,
            ),
          ),
          Text(
            actor.character,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.bodyText1,
          ),
          Text(
            actor.name,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.caption,
          )
        ],
      ),
    );
  }
}
