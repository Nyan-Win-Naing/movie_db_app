import 'package:flutter/material.dart';
import 'package:movie_db_app/data/vos/actor_vo.dart';
import 'package:movie_db_app/resources/dimens.dart';
import 'package:movie_db_app/viewitems/actor_view.dart';

class HorizontalActorListView extends StatelessWidget {

  final List<ActorVO> creditsList;


  HorizontalActorListView({required this.creditsList});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 180,
      child: ListView.builder(
        padding: EdgeInsets.only(left: MARGIN_MEDIUM_2),
        scrollDirection: Axis.horizontal,
        itemCount: creditsList.length,
        itemBuilder: (context, index) {
          return ActorView(credit: creditsList[index]);
        },
      ),
    );
  }
}
