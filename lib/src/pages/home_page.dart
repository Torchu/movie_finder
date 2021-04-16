import 'package:flutter/material.dart';
import 'package:movie_finder/src/widgets/card_swiper_widget.dart';

class HomePage extends StatelessWidget {
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
            // children: <Widget>[_moviesCards()],
            children: <Widget>[CardSwiper(cards: [1,2,3,4,5])],
          ),
        ));
  }

  /*Widget _moviesCards() {
    return CardSwiper(cards: [1, 2, 3, 4, 5]);
  }*/
}
