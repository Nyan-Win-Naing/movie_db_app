import 'package:flutter/material.dart';
import 'package:movie_db_app/data/vos/actor_vo.dart';
import 'package:movie_db_app/network/api_constants.dart';
import 'package:movie_db_app/resources/colors.dart';
import 'package:movie_db_app/resources/dimens.dart';

class ActorView extends StatelessWidget {

  final ActorVO? credit;


  ActorView({required this.credit});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 160,
      margin: const EdgeInsets.only(right: MARGIN_CARD_MEDIUM_2),
      child: Stack(
        children: [
          Positioned.fill(
            child: ActorImageView(imageUrl: credit?.profilePath ?? "",),
          ),
          const Align(
            alignment: Alignment.topRight,
            child: LikeView(),
          ),
          Align(
            alignment: Alignment.bottomLeft,
            child: ActorNameAndLikedView(name: credit?.name ?? ""),
          )
        ],
      ),
    );
  }
}

class ActorNameAndLikedView extends StatelessWidget {

  final String name;


  ActorNameAndLikedView({required this.name});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: MARGIN_MEDIUM, bottom: MARGIN_MEDIUM),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            name,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w600,
              fontSize: TEXT_13,
            ),
          ),
          const SizedBox(height: MARGIN_SMALL),
          Row(
            children: const [
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
    return const Padding(
      padding: EdgeInsets.only(top: MARGIN_MEDIUM, right: MARGIN_MEDIUM),
      child: Icon(
        Icons.favorite_border,
        color: Colors.white,
      ),
    );
  }
}

class ActorImageView extends StatelessWidget {

  final String imageUrl;


  ActorImageView({required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Image.network(
      (imageUrl != null && imageUrl.isNotEmpty) ? "$IMAGE_BASE_URL$imageUrl" : "https://media.istockphoto.com/id/1273297997/vector/default-avatar-profile-icon-grey-photo-placeholder-hand-drawn-modern-man-avatar-profile-icon.jpg?s=612x612&w=0&k=20&c=n_K0uxMqCdHRxgeHYIQbzKebDeDMpY2TuqKsknTHcts=",
      fit: BoxFit.cover,
    );
  }
}
