import 'package:flutter/material.dart';
import 'package:movie_db_app/resources/colors.dart';

class MovieSearchPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HOME_SCREEN_BACKGROUND_COLOR,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60),
        child: AppBar(
          backgroundColor: PRIMARY_COLOR,
          leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(
              Icons.arrow_back_ios,
              color: Colors.white,
            ),
          ),
          title: TextField(
            autofocus: true,
            cursorColor: PLAY_BUTTON_COLOR,
            style: TextStyle(
              color: Colors.white,
            ),
            decoration: InputDecoration(
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.white),
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: PLAY_BUTTON_COLOR),
              ),
              hintText: "Search Movies",
              hintStyle: TextStyle(
                color: TITLE_TEXT_COLOR,
              )
            ),
          ),
        ),
      ),
    );
  }
}
