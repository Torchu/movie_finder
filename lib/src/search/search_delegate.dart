import 'package:flutter/material.dart';
import 'package:movie_finder/src/models/movie_model.dart';
import 'package:movie_finder/src/providers/movies_provider.dart';

class MovieSearch extends SearchDelegate {
  final movieProvider = new MovieProvider();

  @override
  List<Widget> buildActions(BuildContext context) {
    // Actions of search bar (clear search, cancel, etc.)
    return [
      IconButton(
          icon: Icon(Icons.clear),
          onPressed: () {
            query = '';
          })
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    // Fixed icons (like a search icon on the left)
    return IconButton(
        icon: AnimatedIcon(
            icon: AnimatedIcons.menu_arrow, progress: transitionAnimation),
        onPressed: () {
          close(context, null);
        });
  }

  @override
  Widget buildResults(BuildContext context) {
    // Generate the results of the search
    return Container();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // Generate suggestions while typing
    return query.isEmpty
        ? Container()
        : FutureBuilder(
            future: movieProvider.searchMovie(query),
            builder: (BuildContext context, AsyncSnapshot<MovieList> snapshot) {
              return snapshot.hasData
                  ? ListView(
                      children: snapshot.data.items.map((movie) {
                        return ListTile(
                          leading: FadeInImage(
                            image: movie.getPosterImg(),
                            placeholder: AssetImage('assets/img/no-image.jpg'),
                            width: MediaQuery.of(context).size.width * 0.1,
                            fit: BoxFit.contain,
                          ),
                          title: Text(movie.title),
                          subtitle: Text(movie.overview,
                              overflow: TextOverflow.ellipsis),
                          onTap: () {
                            close(context, null);
                            movie.tagId = '';
                            Navigator.pushNamed(context, 'details',
                                arguments: movie);
                          },
                        );
                      }).toList(),
                    )
                  : Container(
                      height: MediaQuery.of(context).size.height * 0.5,
                      child: Center(child: CircularProgressIndicator()));
            },
          );
  }
}
