import 'package:flutter/material.dart';
import 'package:movie_db_app/resources/dimens.dart';
import 'package:movie_db_app/viewitems/actor_view.dart';

class HorizontalActorListView extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 180,
      child: ListView.builder(
        padding: EdgeInsets.only(left: MARGIN_MEDIUM_2),
        scrollDirection: Axis.horizontal,
        itemCount: 10,
        itemBuilder: (context, index) {
          return ActorView();
        },
      ),
    );
  }
}
