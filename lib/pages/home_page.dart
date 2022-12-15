import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:movie_db_app/pages/movie_details_page.dart';
import 'package:movie_db_app/pages/movie_search_page.dart';
import 'package:movie_db_app/resources/colors.dart';
import 'package:movie_db_app/resources/dimens.dart';
import 'package:movie_db_app/resources/strings.dart';
import 'package:movie_db_app/viewitems/banner_view.dart';
import 'package:movie_db_app/viewitems/movie_view.dart';
import 'package:movie_db_app/widgets/horizontal_actor_list_view.dart';
import 'package:movie_db_app/widgets/title_text_view.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: PRIMARY_COLOR,
        title: Text(
          "Discover",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w600,
          ),
        ),
        leading: Icon(
          Icons.menu,
          color: Colors.white,
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: MARGIN_MEDIUM_2),
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MovieSearchPage(),
                  ),
                );
              },
              child: Icon(
                Icons.search,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
      body: Container(
        color: HOME_SCREEN_BACKGROUND_COLOR,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              BannerSectionView(),
              SizedBox(height: MARGIN_MEDIUM_2),
              BestPopularMovieSectionView(),
              SizedBox(height: MARGIN_MEDIUM),
              CheckMovieShowtimesSectionView(),
              SizedBox(height: MARGIN_MEDIUM),
              GenreSectionView(),
              BestActorsSectionView(),
            ],
          ),
        ),
      ),
    );
  }
}

class CheckMovieShowtimesSectionView extends StatelessWidget {
  const CheckMovieShowtimesSectionView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: MARGIN_MEDIUM_2),
      padding: EdgeInsets.symmetric(
          vertical: MARGIN_MEDIUM_2, horizontal: MARGIN_MEDIUM_2),
      height: 160,
      color: ACTOR_SECTION_BACKGROUND_COLOR,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Check Movie\nShowTimes",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: TEXT_HEADING_1X,
                    fontWeight: FontWeight.w600),
              ),
              Text(
                "SEE MORE",
                style: TextStyle(
                  color: PLAY_BUTTON_COLOR,
                  fontWeight: FontWeight.w500,
                  decoration: TextDecoration.underline,
                ),
              ),
            ],
          ),
          Icon(
            Icons.location_on,
            color: Colors.white,
            size: MARGIN_XXLARGE,
          ),
        ],
      ),
    );
  }
}

class BestActorsSectionView extends StatelessWidget {
  const BestActorsSectionView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: ACTOR_SECTION_BACKGROUND_COLOR,
      padding: EdgeInsets.symmetric(vertical: MARGIN_CARD_MEDIUM_2),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: MARGIN_MEDIUM_2),
            child: TitleTextWithMoreView(
                title: "BEST ACTORS", moreLabel: "MOER ACTORS"),
          ),
          SizedBox(height: MARGIN_MEDIUM_2),
          HorizontalActorListView(),
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
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: MARGIN_MEDIUM_2),
          child: DefaultTabController(
            length: 10,
            child: TabBar(
              isScrollable: true,
              indicatorColor: PLAY_BUTTON_COLOR,
              unselectedLabelColor: TITLE_TEXT_COLOR,
              tabs: [
                MovieTabView(),
                MovieTabView(),
                MovieTabView(),
                MovieTabView(),
                MovieTabView(),
                MovieTabView(),
                MovieTabView(),
                MovieTabView(),
                MovieTabView(),
                MovieTabView(),
              ],
            ),
          ),
        ),
        Container(
          color: PRIMARY_COLOR,
          padding: EdgeInsets.only(top: MARGIN_MEDIUM_3, bottom: MARGIN_MEDIUM),
          child: HorizontalMovieListView(),
        ),
      ],
    );
  }
}

class MovieTabView extends StatelessWidget {
  const MovieTabView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Tab(
      child: Text("Animation"),
    );
  }
}

class BestPopularMovieSectionView extends StatelessWidget {
  const BestPopularMovieSectionView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: MARGIN_MEDIUM_2),
          child: TitleTextWithMoreView(title: "BEST POPULAR FILMS AND SERIALS"),
        ),
        SizedBox(height: MARGIN_MEDIUM_2),
        HorizontalMovieListView(),
      ],
    );
  }
}

class HorizontalMovieListView extends StatelessWidget {
  const HorizontalMovieListView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 260,
      child: ListView.builder(
        padding: EdgeInsets.only(left: MARGIN_MEDIUM_2),
        scrollDirection: Axis.horizontal,
        itemCount: 10,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => MovieDetailsPage(),
                ),
              );
            },
            child: MovieView(),
          );
        },
      ),
    );
  }
}

class BannerSectionView extends StatefulWidget {
  const BannerSectionView({
    Key? key,
  }) : super(key: key);

  @override
  State<BannerSectionView> createState() => _BannerSectionViewState();
}

class _BannerSectionViewState extends State<BannerSectionView> {
  double _position = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: MediaQuery.of(context).size.height / 3.5,
          child: PageView(
            children: [
              BannerView(),
              BannerView(),
              BannerView(),
              BannerView(),
              BannerView(),
            ],
            onPageChanged: (page) {
              setState(() {
                _position = page.toDouble();
              });
            },
          ),
        ),
        SizedBox(height: MARGIN_MEDIUM_2),
        DotsIndicator(
          dotsCount: 5,
          position: _position,
          decorator: DotsDecorator(
            color: Colors.grey,
            activeColor: PLAY_BUTTON_COLOR,
          ),
        ),
      ],
    );
  }
}
