import 'package:flutter/material.dart';
import 'package:movie_db_app/resources/colors.dart';
import 'package:movie_db_app/resources/dimens.dart';
import 'package:movie_db_app/widgets/gradient_view.dart';
import 'package:movie_db_app/widgets/horizontal_actor_list_view.dart';
import 'package:movie_db_app/widgets/rating_view.dart';
import 'package:movie_db_app/widgets/title_text_view.dart';

class MovieDetailsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: HOME_SCREEN_BACKGROUND_COLOR,
        child: CustomScrollView(
          slivers: [
            MovieDetailSliverAppBarView(
              onTap: () {
                Navigator.pop(context);
              },
            ),
            SliverList(
              delegate: SliverChildListDelegate(
                [
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: MARGIN_MEDIUM_2),
                    child: GenreSectionView(),
                  ),
                  SizedBox(height: MARGIN_MEDIUM_2),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: MARGIN_MEDIUM_2),
                    child: TrailerSectionView(),
                  ),
                  ActorListSectionView(title: "ACTORS"),
                  AboutFilmSectionView(),
                  ActorListSectionView(title: "CREATORS"),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class AboutFilmSectionView extends StatelessWidget {
  const AboutFilmSectionView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: PRIMARY_COLOR,
      padding: EdgeInsets.symmetric(vertical: MARGIN_MEDIUM_3),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: MARGIN_MEDIUM_2),
            child: TitleTextWithMoreView(title: "ABOUT FILM"),
          ),
          SizedBox(height: MARGIN_MEDIUM_2),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: MARGIN_MEDIUM_2),
            child: Column(
              children: [
                AboutFilmLabelAndDescriptionView(
                  label: "Original Title",
                  description: "Fantastic Beasts and Where to Find Them",
                ),
                SizedBox(height: MARGIN_MEDIUM),
                AboutFilmLabelAndDescriptionView(
                  label: "Type",
                  description: "Family, Fantasy, Adventure",
                ),
                SizedBox(height: MARGIN_MEDIUM),
                AboutFilmLabelAndDescriptionView(
                  label: "Production",
                  description: "United Kingdom, USA",
                ),
                SizedBox(height: MARGIN_MEDIUM),
                AboutFilmLabelAndDescriptionView(
                  label: "Premiere",
                  description: "8 November 2016(World)",
                ),
                SizedBox(height: MARGIN_MEDIUM),
                AboutFilmLabelAndDescriptionView(
                  label: "Description",
                  description: "Fantastic Beasts is a film series directed by David Yates, and a spin-off prequel to the Harry Potter novel and film series. The series is distributed by Warner Bros. and consists of three fantasy films as of 2022, beginning with Fantastic Beasts and Where to Find Them (2016), and following with Fantastic Beasts: The Crimes of Grindelwald (2018) and Fantastic Beasts: The Secrets of Dumbledore (2022).",
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
            style: TextStyle(
              color: Color.fromRGBO(44, 49, 58, 1.0),
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        Expanded(
          child: Text(
            description,
            style: TextStyle(
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


  ActorListSectionView({required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: ACTOR_SECTION_BACKGROUND_COLOR,
      padding: EdgeInsets.symmetric(vertical: MARGIN_MEDIUM_3),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: MARGIN_MEDIUM_2),
            child: TitleTextWithMoreView(title: title),
          ),
          SizedBox(height: MARGIN_MEDIUM_2),
          HorizontalActorListView(),
        ],
      ),
    );
  }
}

class TrailerSectionView extends StatelessWidget {
  const TrailerSectionView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TitleTextWithMoreView(title: "STORYLINE"),
        SizedBox(height: MARGIN_MEDIUM),
        Text(
          "Logan travels to Tokyo to meet Yashida, an old acquaintance who is dying. The situation regresses when Yashida offers to take away his healing abilities, but Logan refuses.",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w500,
            height: 1.5,
          ),
        ),
        SizedBox(height: MARGIN_MEDIUM_2),
        Row(
          children: [
            PlayButtonView(
              label: "PLAY TRAILER",
              iconData: Icons.play_circle_fill,
            ),
            SizedBox(width: MARGIN_MEDIUM),
            PlayButtonView(
              label: "RATE MOVIE",
              iconData: Icons.star,
              isPlayTrailer: false,
            ),
          ],
        ),
        SizedBox(height: MARGIN_MEDIUM_2),
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
      padding: EdgeInsets.symmetric(
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
                ? Color.fromRGBO(0, 0, 0, 0.5)
                : PLAY_BUTTON_COLOR,
          ),
          SizedBox(width: MARGIN_MEDIUM),
          Text(
            label,
            style: TextStyle(
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
  const GenreSectionView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Wrap(
      crossAxisAlignment: WrapCrossAlignment.center,
      children: [
        MovieDurationView(),
        SizedBox(width: MARGIN_MEDIUM),
        GenreChipView(),
        SizedBox(width: MARGIN_MEDIUM),
        GenreChipView(),
      ],
    );
  }
}

class GenreChipView extends StatelessWidget {
  const GenreChipView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Chip(
      padding: EdgeInsets.zero,
      backgroundColor: Color.fromRGBO(0, 0, 0, 0.8),
      label: Text(
        "Family",
        style: TextStyle(
          color: Colors.white,
        ),
      ),
    );
  }
}

class MovieDurationView extends StatelessWidget {
  const MovieDurationView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          Icons.access_time,
          color: Colors.amber,
          size: MARGIN_MEDIUM_3,
        ),
        SizedBox(width: MARGIN_MEDIUM),
        Text(
          "2h 13min",
          style: TextStyle(
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

  MovieDetailSliverAppBarView({required this.onTap});

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
              child: MovieImageView(),
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
            Align(
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
                child: TitleAndRatingView(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class TitleAndRatingView extends StatelessWidget {
  const TitleAndRatingView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ReleaseYearView(),
            RatingAndVoteView(),
          ],
        ),
        SizedBox(height: MARGIN_MEDIUM_2),
        Text(
          "Fantastic Beasts and Where to Find Them",
          style: TextStyle(
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
  const RatingAndVoteView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            RatingView(),
            SizedBox(height: MARGIN_SMALL),
            Text(
              "38876 VOTES",
              style: TextStyle(
                color: TITLE_TEXT_COLOR,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
        SizedBox(width: MARGIN_MEDIUM),
        Text(
          "9,75",
          style: TextStyle(
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
  const ReleaseYearView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
          horizontal: MARGIN_MEDIUM, vertical: MARGIN_MEDIUM),
      decoration: BoxDecoration(
        color: PLAY_BUTTON_COLOR,
        borderRadius: BorderRadius.circular(MARGIN_LARGE),
      ),
      child: Text(
        "2016",
        style: TextStyle(
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
    return Padding(
      padding:
          const EdgeInsets.only(top: MARGIN_XXLARGE, right: MARGIN_MEDIUM_2),
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
      margin: EdgeInsets.only(top: MARGIN_XXLARGE, left: MARGIN_MEDIUM_2),
      padding: EdgeInsets.only(left: MARGIN_MEDIUM),
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        color: Color.fromRGBO(0, 0, 0, 0.8),
        shape: BoxShape.circle,
      ),
      child: Icon(
        Icons.arrow_back_ios,
        color: Colors.white,
      ),
    );
  }
}

class MovieImageView extends StatelessWidget {
  const MovieImageView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Image.network(
      "https://cdn.mos.cms.futurecdn.net/5bjWXV2BHj7hpzrJkpVGa4.jpg",
      fit: BoxFit.cover,
    );
  }
}
