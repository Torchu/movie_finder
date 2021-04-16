import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

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
            children: <Widget>[_cardSwiper()],
          ),
        ));
  }

  Widget _cardSwiper() {
    return Container(
      padding: EdgeInsets.only(top: 10.0),
      width: double.infinity,
      height: 300.0,
      child: Swiper(
        layout: SwiperLayout.STACK,
        itemWidth: 200.0,
        itemBuilder: (BuildContext context,int index) {
          return Image.network("https://openclipart.org/image/2400px/svg_to_png/194077/Placeholder.png",
                                fit: BoxFit.fill,);
        },
        itemCount: 3,
        // pagination: new SwiperPagination(),
        // control: new SwiperControl(),
      ),
    );
  }
}
