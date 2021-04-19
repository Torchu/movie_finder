import 'package:flutter/material.dart';

class Actor {
  bool adult;
  int gender;
  int id;
  String knownForDepartment;
  String name;
  String originalName;
  double popularity;
  String profilePath;
  int castId;
  String character;
  String creditId;
  int order;

  Actor({
    this.adult,
    this.gender,
    this.id,
    this.knownForDepartment,
    this.name,
    this.originalName,
    this.popularity,
    this.profilePath,
    this.castId,
    this.character,
    this.creditId,
    this.order
  });
  
  Actor.fromJSONMap( Map<String, dynamic> json) {
    adult = json['adult'];
    gender = json['gender'];
    id = json['id'];
    knownForDepartment = json['known_for_department'];
    name = json['name'];
    originalName = json['original_name'];
    popularity = json['popularity'];
    profilePath = json['profile_path'];
    castId = json['cast_id'];
    character = json['character'];
    creditId = json['credit_id'];
    order = json['order'];
  }

  ImageProvider<dynamic> getProfileImg() {
    return profilePath != null
        ? NetworkImage('https://image.tmdb.org/t/p/w500$profilePath')
        : AssetImage('assets/img/no-image.jpg');
  }
}

class ActorList {
  List<Actor> items = [];
  int total = 0;

  ActorList();

  ActorList.fromJSONList(List<dynamic> jsonList) {
    if (jsonList != null) {
      for (var item in jsonList) {
        final movie = new Actor.fromJSONMap(item);
        this.items.add(movie);
        this.total += 1;
      }
    }
  }
}