import 'package:flutter/material.dart';
import 'package:movie_finder/src/pages/home_page.dart';
import 'package:movie_finder/src/pages/movie_details_page.dart';
 
void main() => runApp(MyApp());
 
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Movie Finder',
      initialRoute: '/',
      routes: {
        '/': (BuildContext context ) => HomePage(),
        'details' : (BuildContext context) => MovieDetails()
      },
    );
  }
}