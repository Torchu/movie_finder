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
            _createMovieTitle(movie, context),
            _createMovieDescription(movie, context),
            _createMovieCasting(movie, context),
            _createRecommendations(movie, context)
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

  Widget _createMovieTitle(Movie movie, BuildContext context) {
    final _screenSize = MediaQuery.of(context).size;
    return Container(
      padding: EdgeInsets.symmetric(horizontal: _screenSize.width * 0.05),
      child: Row(
        children: <Widget>[
          Hero(
            tag: movie.tagId,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20.0),
              child: Image(
                  image: movie.getPosterImg(),
                  height: _screenSize.height * 0.16),
            ),
          ),
          SizedBox(width: _screenSize.width * 0.05),
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

  Widget _createMovieDescription(Movie movie, BuildContext context) {
    final _screenSize = MediaQuery.of(context).size;
    return Container(
        padding: EdgeInsets.symmetric(
            horizontal: _screenSize.height * 0.01,
            vertical: _screenSize.width * 0.05),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text('Overview', style: Theme.of(context).textTheme.headline6),
            SizedBox(
              height: _screenSize.height * 0.02,
            ),
            Text(movie.overview,
                textAlign: TextAlign.justify, style: TextStyle(fontSize: 16.0)),
          ],
        ));
  }

  Widget _createMovieCasting(Movie movie, BuildContext context) {
    final movieProvider = new MovieProvider();
    final _screenSize = MediaQuery.of(context).size;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          padding: EdgeInsets.symmetric(horizontal: _screenSize.height * 0.01),
          child: Text('Cast', style: Theme.of(context).textTheme.headline6),
        ),
        SizedBox(
          height: _screenSize.height * 0.02,
        ),
        FutureBuilder(
          future: movieProvider.getCast(movie.id),
          builder: (BuildContext context, AsyncSnapshot<ActorList> snapshot) {
            return snapshot.hasData
                ? _createActorsPageView(snapshot.data, context)
                : Container(
                    height: _screenSize.height * 0.5,
                    child: Center(child: CircularProgressIndicator()));
          },
        ),
      ],
    );
  }

  Widget _createActorsPageView(ActorList cast, BuildContext context) {
    final _screenSize = MediaQuery.of(context).size;
    return SizedBox(
      height: _screenSize.height * 0.2,
      child: PageView.builder(
          pageSnapping: false,
          itemCount: cast.total,
          controller: PageController(viewportFraction: 0.3, initialPage: 1),
          itemBuilder: (context, i) =>
              _createActorCard(cast.items[i], context)),
    );
  }

  Widget _createActorCard(Actor actor, BuildContext context) {
    final _screenSize = MediaQuery.of(context).size;
    return Container(
      child: Column(
        children: <Widget>[
          ClipRRect(
            borderRadius: BorderRadius.circular(20.0),
            child: FadeInImage(
              image: actor.getProfileImg(),
              placeholder: AssetImage('assets/img/no-image.jpg'),
              fit: BoxFit.cover,
              height: _screenSize.height * 0.15,
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

  Widget _createRecommendations(Movie movie, BuildContext context) {
    final _screenSize = MediaQuery.of(context).size;
    final movieProvider = new MovieProvider();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          padding: EdgeInsets.symmetric(horizontal: _screenSize.height * 0.01),
          child: Text('If you liked ${movie.title}',
              style: Theme.of(context).textTheme.headline6),
        ),
        SizedBox(
          height: _screenSize.height * 0.02,
        ),
        FutureBuilder(
          future: movieProvider.getRecommendations(movie.id),
          builder: (BuildContext context, AsyncSnapshot<MovieList> snapshot) {
            return snapshot.hasData
                ? _createRecommendationsPageView(snapshot.data, context)
                : Container(
                    height: _screenSize.height * 0.5,
                    child: Center(child: CircularProgressIndicator()));
          },
        ),
      ],
    );
  }

  Widget _createRecommendationsPageView(MovieList recommendations, BuildContext context) {
    final _screenSize = MediaQuery.of(context).size;
    return SizedBox(
      height: _screenSize.height * 0.2,
      child: PageView.builder(
          pageSnapping: false,
          itemCount: recommendations.total,
          controller: PageController(viewportFraction: 0.3, initialPage: 1),
          itemBuilder: (context, i) =>
              _createRecommendationCard(recommendations.items[i], context)),
    );
  }

  Widget _createRecommendationCard(Movie movie, BuildContext context) {
    final _screenSize = MediaQuery.of(context).size;
    movie.tagId = '${movie.id}-recommendation';
    final card = Container(
      child: Column(
        children: <Widget>[
          Hero(
            tag: movie.tagId,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20.0),
              child: FadeInImage(
                image: movie.getPosterImg(),
                placeholder: AssetImage('assets/img/no-image.jpg'),
                fit: BoxFit.cover,
                height: _screenSize.height * 0.15,
              ),
            ),
          ),
          Text(
            movie.title,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.bodyText1,
          ),
        ],
      ),
    );

    return GestureDetector(
      child: card,
      onTap: () {
        Navigator.pushNamed(context, 'details', arguments: movie);
      },
    );
  }
}
