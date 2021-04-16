import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:movie_finder/src/models/movie_model.dart';

class MovieProvider {
  // Since we have no backend, we must store here the api key
  // TODO: Erase the apikey if a backend is built
  String _apikey = '3527302a71bc5f1fb95f634007e123d2';
  String _url = 'api.themoviedb.org';
  String _language = 'en-US';

  Future<MovieList> getNowPlaying() async {
    final url = Uri.https(_url, '3/movie/now_playing',
        {'api_key': _apikey, 'language': _language});

    final response = await http.get(url);
    final decodedData = json.decode(response.body);

    return new MovieList.fromJSONList(decodedData['results']);
  }
}
