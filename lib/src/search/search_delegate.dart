import 'package:flutter/material.dart';

class MovieSearch extends SearchDelegate {
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
    return Container();
  }
}
