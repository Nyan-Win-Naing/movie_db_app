import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/get_core.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:movie_db_app/controller/movies_details_controller.dart';
import 'package:movie_db_app/data/vos/actor_vo.dart';
import 'package:movie_db_app/data/vos/genre_vo.dart';
import 'package:movie_db_app/data/vos/movie_vo.dart';
import 'package:movie_db_app/network/api_constants.dart';
import 'package:movie_db_app/resources/colors.dart';
import 'package:movie_db_app/resources/dimens.dart';
import 'package:movie_db_app/resources/strings.dart';
import 'package:movie_db_app/viewitems/movie_view_for_horiz_list.dart';
import 'package:movie_db_app/widgets/gradient_view.dart';
import 'package:movie_db_app/widgets/horizontal_actor_list_view.dart';
import 'package:movie_db_app/widgets/rating_view.dart';
import 'package:movie_db_app/widgets/title_text_view.dart';

class MovieDetailsPage extends StatelessWidget {
  final int movieId;
  final int tabIndex;
  final MovieDetailsController mMovieDetailController =
      MovieDetailsController();

  MovieDetailsPage({required this.movieId, required this.tabIndex});

  @override
  Widget build(BuildContext context) {
    mMovieDetailController.fetchMovieDetails(movieId, tabIndex);
    return Scaffold(
      body: Container(
        color: HOME_SCREEN_BACKGROUND_COLOR,
        child: Obx(
          () => CustomScrollView(
            slivers: [
              MovieDetailSliverAppBarView(
                onTap: () {
                  Navigator.pop(context);
                },
                movie: mMovieDetailController.mMovieDetail.value,
              ),
              SliverList(
                delegate: SliverChildListDelegate(
                  [
                    Container(
                      margin: const EdgeInsets.symmetric(
                          horizontal: MARGIN_MEDIUM_2),
                      child: GenreSectionView(
                          movie: mMovieDetailController.mMovieDetail.value),
                    ),
                    const SizedBox(height: MARGIN_MEDIUM_2),
                    Container(
                      margin: const EdgeInsets.symmetric(
                          horizontal: MARGIN_MEDIUM_2),
                      child: TrailerSectionView(
                        mMovieDetailController.mMovieDetail.value.overview ??
                            "",
                      ),
                    ),
                    ActorListSectionView(
                      title: TITTLE_ACTORS_TEXT,
                      creditsList: mMovieDetailController.mActorList.toList(),
                    ),
                    AboutFilmSectionView(
                      movie: mMovieDetailController.mMovieDetail.value,
                    ),
                    ActorListSectionView(
                      title: TITLE_CREATORS_TEXT,
                      creditsList: mMovieDetailController.mCreatorList.toList(),
                    ),
                    MoviesByGenreSectionView(
                      genreList: mMovieDetailController.mGenreList.toList(),
                      moviesByGenre:
                          mMovieDetailController.mMoviesByGenre.toList(),
                      onTap: (genreId) {
                        mMovieDetailController.onTapGenre(genreId);
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class MoviesByGenreSectionView extends StatelessWidget {
  final List<GenreVO> genreList;
  final List<MovieVO> moviesByGenre;
  final Function(int) onTap;

  MoviesByGenreSectionView({
    required this.genreList,
    required this.moviesByGenre,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          color: ACTOR_SECTION_BACKGROUND_COLOR,
          child: Padding(
            padding: const EdgeInsets.only(
              top: MARGIN_MEDIUM_2,
              left: MARGIN_MEDIUM_2,
              right: MARGIN_MEDIUM_2,
            ),
            child: DefaultTabController(
              length: genreList.length,
              child: TabBar(
                isScrollable: true,
                indicatorColor: PLAY_BUTTON_COLOR,
                unselectedLabelColor: TITLE_TEXT_COLOR,
                tabs: genreList
                    .map((genre) => GenreTabView(
                          genre: genre.name ?? "",
                        ))
                    .toList(),
                onTap: (tabIndex) {
                  onTap(genreList[tabIndex].id ?? 0);
                },
              ),
            ),
          ),
        ),
        Container(
          color: PRIMARY_COLOR,
          padding: const EdgeInsets.symmetric(vertical: MARGIN_MEDIUM),
          child: Container(
            height: MOVIE_LIST_HEIGHT,
            child: ListView.builder(
              padding: const EdgeInsets.only(left: MARGIN_MEDIUM_2),
              scrollDirection: Axis.horizontal,
              itemCount: moviesByGenre.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    print("Tap Tap works..........");
                    Get.to(
                      () => MovieDetailsPage(
                        movieId: moviesByGenre[index].id ?? 0,
                        tabIndex: -1,
                      ),
                      preventDuplicates: false,
                    );
                  },
                  child: MovieViewForHorizontalList(
                    movie: moviesByGenre[index],
                  ),
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}

class GenreTabView extends StatelessWidget {
  final String genre;

  GenreTabView({required this.genre});

  @override
  Widget build(BuildContext context) {
    return Tab(
      child: Text(genre),
    );
  }
}

class AboutFilmSectionView extends StatelessWidget {
  final MovieVO? movie;

  AboutFilmSectionView({required this.movie});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: PRIMARY_COLOR,
      padding: const EdgeInsets.symmetric(vertical: MARGIN_MEDIUM_3),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: MARGIN_MEDIUM_2),
            child: TitleTextWithMoreView(title: ABOUT_FILM_TITLE),
          ),
          const SizedBox(height: MARGIN_MEDIUM_2),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: MARGIN_MEDIUM_2),
            child: Column(
              children: [
                AboutFilmLabelAndDescriptionView(
                  label: LABEL_ORIGINAL_TITLE,
                  description: movie?.originalTitle ?? "",
                ),
                const SizedBox(height: MARGIN_MEDIUM),
                AboutFilmLabelAndDescriptionView(
                  label: LABEL_TYPE,
                  description: movie?.getGenresWithCommaSeparatedValue() ?? "",
                ),
                const SizedBox(height: MARGIN_MEDIUM),
                AboutFilmLabelAndDescriptionView(
                  label: LABEL_PRODUCTION,
                  description:
                      movie?.getProductionCountriesWithCommaSeparated() ?? "",
                ),
                const SizedBox(height: MARGIN_MEDIUM),
                AboutFilmLabelAndDescriptionView(
                  label: LABEL_PREMIERE,
                  description: movie?.releaseDate ?? "",
                ),
                const SizedBox(height: MARGIN_MEDIUM),
                AboutFilmLabelAndDescriptionView(
                  label: LABEL_DESCRIPTION,
                  description: movie?.overview ?? "",
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class AboutFilmLabelAndDescriptionView extends StatelessWidget {
  final String label;
  final String description;

  AboutFilmLabelAndDescriptionView(
      {required this.label, required this.description});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 110,
          child: Text(
            "$label:",
            style: const TextStyle(
              color: Color.fromRGBO(44, 49, 58, 1.0),
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        Expanded(
          child: Text(
            description,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w500,
              height: 1.3,
            ),
          ),
        ),
      ],
    );
  }
}

class ActorListSectionView extends StatelessWidget {
  final String title;
  final List<ActorVO> creditsList;

  ActorListSectionView({required this.title, required this.creditsList});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: ACTOR_SECTION_BACKGROUND_COLOR,
      padding: const EdgeInsets.symmetric(vertical: MARGIN_MEDIUM_3),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: MARGIN_MEDIUM_2),
            child: TitleTextWithMoreView(title: title),
          ),
          const SizedBox(height: MARGIN_MEDIUM_2),
          HorizontalActorListView(creditsList: creditsList),
        ],
      ),
    );
  }
}

class TrailerSectionView extends StatelessWidget {
  final String overview;

  TrailerSectionView(this.overview);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TitleTextWithMoreView(title: TITLE_STORY_LINE_TEXT),
        const SizedBox(height: MARGIN_MEDIUM),
        Text(
          overview,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w500,
            height: 1.5,
          ),
        ),
        SizedBox(height: MARGIN_MEDIUM_2),
        Row(
          children: [
            PlayButtonView(
              label: BUTTON_PLAY_TRAILER_LABEL,
              iconData: Icons.play_circle_fill,
            ),
            const SizedBox(width: MARGIN_MEDIUM),
            PlayButtonView(
              label: BUTTON_RATE_MOVIES_LABEL,
              iconData: Icons.star,
              isPlayTrailer: false,
            ),
          ],
        ),
        const SizedBox(height: MARGIN_MEDIUM_2),
      ],
    );
  }
}

class PlayButtonView extends StatelessWidget {
  final String label;
  final IconData iconData;
  final bool isPlayTrailer;

  PlayButtonView({
    required this.label,
    required this.iconData,
    this.isPlayTrailer = true,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
          horizontal: MARGIN_CARD_MEDIUM_2, vertical: MARGIN_MEDIUM),
      decoration: BoxDecoration(
        color: isPlayTrailer ? PLAY_BUTTON_COLOR : Colors.transparent,
        borderRadius: BorderRadius.circular(MARGIN_LARGE),
        border: Border.all(
            color: isPlayTrailer ? PLAY_BUTTON_COLOR : Colors.white, width: 2),
      ),
      child: Row(
        children: [
          Icon(
            iconData,
            color: isPlayTrailer
                ? const Color.fromRGBO(0, 0, 0, 0.5)
                : PLAY_BUTTON_COLOR,
          ),
          const SizedBox(width: MARGIN_MEDIUM),
          Text(
            label,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}

class GenreSectionView extends StatelessWidget {
  final MovieVO? movie;

  GenreSectionView({required this.movie});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      crossAxisAlignment: WrapCrossAlignment.center,
      children: [
        MovieDurationView(
            formattedRunTime: movie?.getFormattedMovieRunTime() ?? ""),
        const SizedBox(width: MARGIN_MEDIUM),
        ...movie?.genres
                ?.map((genre) => GenreChipView(genre: genre.name ?? ""))
                .toList() ??
            [],
      ],
    );
  }
}

class GenreChipView extends StatelessWidget {
  final String genre;

  GenreChipView({required this.genre});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: MARGIN_MEDIUM),
      child: Chip(
        padding: EdgeInsets.zero,
        backgroundColor: const Color.fromRGBO(0, 0, 0, 0.8),
        label: Text(
          genre,
          style: const TextStyle(
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}

class MovieDurationView extends StatelessWidget {
  final String formattedRunTime;

  MovieDurationView({required this.formattedRunTime});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Icon(
          Icons.access_time,
          color: Colors.amber,
          size: MARGIN_MEDIUM_3,
        ),
        const SizedBox(width: MARGIN_MEDIUM),
        Text(
          formattedRunTime,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w500,
            fontSize: TEXT_13,
          ),
        ),
      ],
    );
  }
}

class MovieDetailSliverAppBarView extends StatelessWidget {
  final Function onTap;
  final MovieVO? movie;

  MovieDetailSliverAppBarView({required this.onTap, required this.movie});

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      backgroundColor: PRIMARY_COLOR,
      automaticallyImplyLeading: false,
      expandedHeight: 300,
      flexibleSpace: FlexibleSpaceBar(
        background: Stack(
          children: [
            Positioned.fill(
              child: MovieImageView(imageUrl: movie?.backDropPath ?? ""),
            ),
            Positioned.fill(
              child: GradientView(),
            ),
            Align(
              alignment: Alignment.topLeft,
              child: GestureDetector(
                onTap: () {
                  onTap();
                },
                child: BackButtonView(),
              ),
            ),
            const Align(
              alignment: Alignment.topRight,
              child: SearchIconView(),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.only(
                    left: MARGIN_MEDIUM_2,
                    right: MARGIN_MEDIUM_2,
                    bottom: MARGIN_MEDIUM),
                child: TitleAndRatingView(movie: movie),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class TitleAndRatingView extends StatelessWidget {
  final MovieVO? movie;

  TitleAndRatingView({required this.movie});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ReleaseYearView(
                releaseDate: movie?.getFormattedReleaseDate() ?? ""),
            RatingAndVoteView(movie: movie),
          ],
        ),
        SizedBox(height: MARGIN_MEDIUM_2),
        Text(
          movie?.title ?? "",
          style: const TextStyle(
            fontSize: TEXT_HEADING_1X,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ],
    );
  }
}

class RatingAndVoteView extends StatelessWidget {
  final MovieVO? movie;

  RatingAndVoteView({required this.movie});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            RatingView(rating: movie?.getRating() ?? 0),
            const SizedBox(height: MARGIN_SMALL),
            Text(
              "${movie?.voteCount} VOTES",
              style: const TextStyle(
                color: TITLE_TEXT_COLOR,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
        SizedBox(width: MARGIN_MEDIUM),
        Text(
          movie?.getVoteAverage() ?? "",
          style: const TextStyle(
            color: Colors.white,
            fontSize: TEXT_BIG,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}

class ReleaseYearView extends StatelessWidget {
  final String releaseDate;

  ReleaseYearView({required this.releaseDate});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
          horizontal: MARGIN_MEDIUM, vertical: MARGIN_MEDIUM),
      decoration: BoxDecoration(
        color: PLAY_BUTTON_COLOR,
        borderRadius: BorderRadius.circular(MARGIN_LARGE),
      ),
      child: Text(
        releaseDate,
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}

class SearchIconView extends StatelessWidget {
  const SearchIconView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.only(top: MARGIN_XXLARGE, right: MARGIN_MEDIUM_2),
      child: Icon(
        Icons.search,
        color: Colors.white,
      ),
    );
  }
}

class BackButtonView extends StatelessWidget {
  const BackButtonView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: MARGIN_XXLARGE, left: MARGIN_MEDIUM_2),
      padding: const EdgeInsets.only(left: MARGIN_MEDIUM),
      width: 40,
      height: 40,
      decoration: const BoxDecoration(
        color: Color.fromRGBO(0, 0, 0, 0.8),
        shape: BoxShape.circle,
      ),
      child: const Icon(
        Icons.arrow_back_ios,
        color: Colors.white,
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
      (imageUrl != null && imageUrl.isNotEmpty)
          ? "$IMAGE_BASE_URL_WITHOUT_SLASH$imageUrl"
          : "https://upload.wikimedia.org/wikipedia/commons/thumb/3/3f/Placeholder_view_vector.svg/681px-Placeholder_view_vector.svg.png",
      fit: BoxFit.cover,
    );
  }
}
