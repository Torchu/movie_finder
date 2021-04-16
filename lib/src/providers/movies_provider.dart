import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:movie_finder/src/models/movie_model.dart';

class MovieProvider {
  // Since we have no backend, we must store here the api key
  // TODO: Erase the apikey if a backend is built
  String _apikey = '3527302a71bc5f1fb95f634007e123d2';
  String _url = 'api.themoviedb.org';
  String _language = 'en-US';

  Future<MovieList> getFromAPI(String path) async {
    final apiPath = Uri.https(_url, '3/movie'+ path,
        {'api_key': _apikey, 'language': _language});
    final response = await http.get(apiPath);
    final decodedData = json.decode(response.body);

    return new MovieList.fromJSONList(decodedData['results']);
  }

  Future<MovieList> getNowPlaying() {
    return getFromAPI('/now_playing');
  }

  Future<MovieList> getPopular() {
    return getFromAPI('/popular');
  }
}
