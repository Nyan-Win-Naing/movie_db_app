import 'package:flutter/material.dart';
import 'package:movie_db_app/resources/colors.dart';
import 'package:movie_db_app/resources/dimens.dart';

class ActorView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 160,
      margin: EdgeInsets.only(right: MARGIN_CARD_MEDIUM_2),
      child: Stack(
        children: [
          Positioned.fill(
            child: ActorImageView(),
          ),
          Align(
            alignment: Alignment.topRight,
            child: LikeView(),
          ),
          Align(
            alignment: Alignment.bottomLeft,
            child: ActorNameAndLikedView(),
          )
        ],
      ),
    );
  }
}

class ActorNameAndLikedView extends StatelessWidget {
  const ActorNameAndLikedView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: MARGIN_MEDIUM, bottom: MARGIN_MEDIUM),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Leonardo DiCaprio",
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w600,
              fontSize: TEXT_13,
            ),
          ),
          SizedBox(height: MARGIN_SMALL),
          Row(
            children: [
              Icon(
                Icons.favorite,
                color: PLAY_BUTTON_COLOR,
                size: MARGIN_MEDIUM_2,
              ),
              SizedBox(width: MARGIN_SMALL),
              Text(
                "YOUR LIKE 15 MOVIES",
                style: TextStyle(
                  fontSize: 10,
                  color: Colors.white70,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class LikeView extends StatelessWidget {
  const LikeView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: MARGIN_MEDIUM, right: MARGIN_MEDIUM),
      child: Icon(
        Icons.favorite_border,
        color: Colors.white,
      ),
    );
  }
}

class ActorImageView extends StatelessWidget {
  const ActorImageView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Image.network(
      "https://images.saymedia-content.com/.image/t_share/MTc0NDI5MTc5NzI1NDg5Nzk4/top-10-greatest-leonardo-dicaprio-movies.jpg",
      fit: BoxFit.cover,
    );
  }
}
