import 'package:flutter/material.dart';
import 'package:movie_db_app/pages/movie_details_page.dart';
import 'package:movie_db_app/pages/movie_search_page.dart';
import 'package:movie_db_app/resources/colors.dart';
import 'package:movie_db_app/resources/dimens.dart';
import 'package:movie_db_app/viewitems/movie_view.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int tabIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ACTOR_SECTION_BACKGROUND_COLOR,
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
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TabBarSectionView(
                onTap: (index) {
                  setState(() {
                    tabIndex = index;
                  });
                },
              ),
              SizedBox(height: MARGIN_MEDIUM_2),
              MovieGridSectionView(tabIndex: tabIndex),
            ],
          ),
        ),
      ),
    );
  }
}

class MovieGridSectionView extends StatelessWidget {
  final int tabIndex;

  MovieGridSectionView({required this.tabIndex});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Visibility(
          visible: tabIndex == 2,
          child: SearchFieldView(),
        ),
        GridView.builder(
          itemCount: 10,
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          padding: EdgeInsets.only(left: MARGIN_MEDIUM_2),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 130 / 190,
          ),
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
      ],
    );
  }
}

class SearchFieldView extends StatelessWidget {
  const SearchFieldView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: MARGIN_MEDIUM_2),
      padding: EdgeInsets.only(bottom: MARGIN_MEDIUM_2),
      child: TextField(
        cursorColor: PLAY_BUTTON_COLOR,
        decoration: InputDecoration(
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: PLAY_BUTTON_COLOR),
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: PLAY_BUTTON_COLOR),
            ),
            hintText: "Search Movies",
            hintStyle: TextStyle(
              color: TITLE_TEXT_COLOR,
            )),
      ),
    );
  }
}

class TabBarSectionView extends StatelessWidget {
  final Function(int) onTap;

  TabBarSectionView({required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: HOME_SCREEN_BACKGROUND_COLOR,
      padding: EdgeInsets.only(
        right: MARGIN_MEDIUM_2,
        left: MARGIN_MEDIUM_2,
        top: MARGIN_MEDIUM_2,
      ),
      child: DefaultTabController(
        length: 3,
        child: TabBar(
          indicatorColor: PLAY_BUTTON_COLOR,
          unselectedLabelColor: TITLE_TEXT_COLOR,
          tabs: [
            CategoryTabView(title: "Now Playing"),
            CategoryTabView(title: "Popular Movies"),
            CategoryTabView(title: "Search Movies"),
          ],
          onTap: (index) {
            onTap(index);
          },
        ),
      ),
    );
  }
}

class CategoryTabView extends StatelessWidget {
  final String title;

  CategoryTabView({required this.title});

  @override
  Widget build(BuildContext context) {
    return Tab(
      child: Text(
        title,
        textAlign: TextAlign.center,
        style: TextStyle(
          height: 1.3,
        ),
      ),
    );
  }
}
