import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:movie_finder/src/models/actors_model.dart';
import 'package:movie_finder/src/models/movie_model.dart';

class MovieProvider {
  // Since we have no backend, we must store here the api key
  // TODO: Erase the apikey if a backend is built
  String _apikey = '3527302a71bc5f1fb95f634007e123d2';
  String _url = 'api.themoviedb.org';
  String _apiPath = '3/movie';
  String _language = 'en-US';
  int _popularPage = 0;
  bool _loadingPopular = false;

  MovieList _popularMovies = new MovieList();
  final _popularStreamController = StreamController<MovieList>.broadcast();

  Function(MovieList) get popularSink => _popularStreamController.sink.add;

  Stream<MovieList> get popularStream => _popularStreamController.stream;

  void disposeStreams() {
    _popularStreamController?.close();
  }

  Future<MovieList> getFromAPI(Uri path) async {
    final response = await http.get(path);
    final decodedData = json.decode(response.body);

    return new MovieList.fromJSONList(decodedData['results']);
  }

  Future<MovieList> getNowPlaying() async {
    final path = Uri.https(_url, _apiPath + '/now_playing',
        {'api_key': _apikey, 'language': _language});

    return await getFromAPI(path);
  }

  void getPopular() async {
    if (!_loadingPopular) {
      _loadingPopular = true;
      _popularPage++;
      final path = Uri.https(_url, _apiPath + '/popular', {
        'api_key': _apikey,
        'language': _language,
        'page': _popularPage.toString()
      });

      final response = await getFromAPI(path);
      _popularMovies.addAll(response);

      popularSink(_popularMovies);
      _loadingPopular = false;
    }
  }

  Future<ActorList> getCast(int movieId) async{
    final path = Uri.https(_url, _apiPath + '/$movieId/credits',
        {'api_key': _apikey, 'language': _language});

    final response = await http.get(path);
    final decodedData = json.decode(response.body);

    return new ActorList.fromJSONList(decodedData['cast']);
  }

  Future<MovieList> searchMovie(String query) async {
    final path = Uri.https(_url, '3/search/movie',
        {'api_key': _apikey, 'language': _language, 'query': query});

    return await getFromAPI(path);
  }
}
