import 'package:flutter/material.dart';
import 'package:movie_db_app/data/vos/movie_vo.dart';
import 'package:movie_db_app/network/api_constants.dart';
import 'package:movie_db_app/resources/dimens.dart';
import 'package:movie_db_app/widgets/rating_view.dart';

class MovieViewForHorizontalList extends StatelessWidget {

  final MovieVO? movie;


  MovieViewForHorizontalList({required this.movie});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 150,
      margin: const EdgeInsets.only(right: MARGIN_CARD_MEDIUM_2),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          MovieImageView(imageUrl: movie?.posterPath ?? ""),
          const SizedBox(height: MARGIN_MEDIUM),
          MovieTitleView(name: movie?.title ?? ""),
          const SizedBox(height: MARGIN_SMALL),
          RatingAndReviewView(
            voteAverage: movie?.voteAverage ?? 0,
            rating: movie?.getRating() ?? 0,
          ),
        ],
      ),
    );
  }
}

class RatingAndReviewView extends StatelessWidget {

  final double voteAverage;
  final double rating;


  RatingAndReviewView({required this.voteAverage, required this.rating});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          "$voteAverage",
          style: const TextStyle(
            color: Colors.white,
            fontSize: TEXT_13,
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(width: MARGIN_MEDIUM),
        RatingView(rating: rating),
      ],
    );
  }
}

class MovieTitleView extends StatelessWidget {
  final String name;


  MovieTitleView({required this.name});

  @override
  Widget build(BuildContext context) {
    return Text(
      name,
      maxLines: 1,
      style: const TextStyle(
        color: Colors.white,
        overflow: TextOverflow.ellipsis,
        fontSize: TEXT_13,
        fontWeight: FontWeight.w600,
      ),
    );
  }
}

class MovieImageView extends StatelessWidget {

  final String imageUrl;


  MovieImageView({required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Image.network(
      (imageUrl != null && imageUrl.isNotEmpty) ? "$IMAGE_BASE_URL$imageUrl" : "https://thumbs.dreamstime.com/b/no-thumbnail-image-placeholder-forums-blogs-websites-148010362.jpg",
      height: 200,
      width: double.infinity,
      fit: BoxFit.cover,
    );
  }
}
