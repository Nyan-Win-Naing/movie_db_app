import 'package:flutter/material.dart';
import 'package:movie_db_app/data/vos/movie_vo.dart';
import 'package:movie_db_app/network/api_constants.dart';
import 'package:movie_db_app/resources/dimens.dart';
import 'package:movie_db_app/resources/strings.dart';
import 'package:movie_db_app/widgets/rating_view.dart';

class MovieView extends StatelessWidget {
  final MovieVO? movie;

  MovieView({required this.movie});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: MARGIN_MEDIUM_2, bottom: MARGIN_MEDIUM),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          FadeInImage(
            height: 180,
            width: double.infinity,
            fit: BoxFit.cover,
            placeholder: const NetworkImage(
              "https://thumbs.dreamstime.com/b/no-thumbnail-image-placeholder-forums-blogs-websites-148010362.jpg",
            ),
            image: NetworkImage(
              (movie?.posterPath != null &&
                      (movie?.posterPath?.isNotEmpty ?? false))
                  ? "$IMAGE_BASE_URL${movie?.posterPath}"
                  : "https://thumbs.dreamstime.com/b/no-thumbnail-image-placeholder-forums-blogs-websites-148010362.jpg",
            ),
          ),
          const SizedBox(height: MARGIN_MEDIUM),
          Text(
            movie?.title ?? "",
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              color: Colors.white,
              fontSize: TEXT_13,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: MARGIN_MEDIUM),
          Row(
            children: [
              Text(
                "${movie?.voteAverage}",
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: TEXT_13,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: MARGIN_SMALL),
              RatingView(rating: movie?.getRating() ?? 0),
            ],
          ),
        ],
      ),
    );
  }
}
