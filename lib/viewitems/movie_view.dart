import 'package:flutter/material.dart';
import 'package:movie_db_app/resources/dimens.dart';
import 'package:movie_db_app/resources/strings.dart';
import 'package:movie_db_app/widgets/rating_view.dart';

class MovieView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: MARGIN_MEDIUM_2),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.network(
            "https://upload.wikimedia.org/wikipedia/en/7/74/The_Wolverine_posterUS.jpg",
            height: 180,
            width: double.infinity,
            fit: BoxFit.cover,
          ),
          SizedBox(height: MARGIN_MEDIUM),
          Text(
            "The Wolverine",
            style: TextStyle(
              color: Colors.white,
              fontSize: TEXT_13,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: MARGIN_MEDIUM),
          Row(
            children: [
              Text(
                "7.1",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: TEXT_13,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: MARGIN_SMALL),
              RatingView(),
            ],
          ),
        ],
      ),
    );
  }
}
