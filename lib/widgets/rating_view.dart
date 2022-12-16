import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:movie_db_app/resources/dimens.dart';

class RatingView extends StatelessWidget {

  final double rating;


  RatingView({required this.rating});

  @override
  Widget build(BuildContext context) {
    return RatingBar.builder(
      initialRating: rating,
      allowHalfRating: true,
      updateOnDrag: false,
      ignoreGestures: true,
      itemBuilder: (context, index) {
        return Icon(
          Icons.star,
          color: Colors.amber,
        );
      },
      itemSize: MARGIN_MEDIUM_2,
      onRatingUpdate: (rating) {},
    );
  }
}
