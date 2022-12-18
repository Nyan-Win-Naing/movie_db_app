import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:movie_db_app/controller/home_controller.dart';
import 'package:movie_db_app/data/vos/movie_vo.dart';
import 'package:movie_db_app/pages/movie_details_page.dart';
import 'package:movie_db_app/pages/movie_search_page.dart';
import 'package:movie_db_app/resources/colors.dart';
import 'package:movie_db_app/resources/dimens.dart';
import 'package:movie_db_app/resources/strings.dart';
import 'package:movie_db_app/utils/debouncer.dart';
import 'package:movie_db_app/viewitems/movie_view.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final HomeController homeController = Get.put(HomeController());
  var scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    scrollController.addListener(() {
      if (scrollController.position.atEdge) {
        if (scrollController.position.pixels == 0) {
          print("Start of the scroll list");
        } else {
          homeController.onScrollEndReached();
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ACTOR_SECTION_BACKGROUND_COLOR,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: PRIMARY_COLOR,
        title: const Text(
          APP_TITLE,
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w600,
          ),
        ),
        leading: const Icon(
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
              child: const Icon(
                Icons.search,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
      body: Container(
        child: SingleChildScrollView(
          controller: scrollController,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TabBarSectionView(
                onTap: (index) {
                  homeController.onTapTab(index);
                },
              ),
              const SizedBox(height: MARGIN_MEDIUM_2),
              Obx(() {
                List<MovieVO> movieList =
                    getMovieListByTabId(homeController.tabIndex.value);
                return MovieGridSectionView(
                  tabIndex: homeController.tabIndex.value,
                  movieList: movieList,
                );
              }),
            ],
          ),
        ),
      ),
    );
  }

  List<MovieVO> getMovieListByTabId(int tabIndex) {
    if (tabIndex == 0) {
      return homeController.nowPlayingMovies.toList();
    } else if (tabIndex == 1) {
      return homeController.popularMovies.toList();
    } else {
      return homeController.searchMovies.toList();
    }
  }
}

class MovieGridSectionView extends StatelessWidget {
  final int tabIndex;
  final List<MovieVO> movieList;
  final _debouncer = CustomDebouncer(milliseconds: 500);
  final HomeController _homeController = Get.find<HomeController>();

  MovieGridSectionView({required this.tabIndex, required this.movieList});

  @override
  Widget build(BuildContext context) {
    return (movieList.isNotEmpty)
        ? Column(
            children: [
              Visibility(
                visible: tabIndex == 2,
                child: SearchFieldView(
                  onChanged: (String keyword) {
                    _debouncer
                        .run(() => _homeController.onSearchMovies(keyword));
                  },
                ),
              ),
              GridView.builder(
                itemCount: movieList.length,
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                padding: const EdgeInsets.only(left: MARGIN_MEDIUM_2),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 130 / 200,
                ),
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      FocusScope.of(context).unfocus();
                      Get.to(
                        () => MovieDetailsPage(
                          movieId: movieList[index].id ?? 0,
                          tabIndex: tabIndex,
                        ),
                      );
                    },
                    child: MovieView(movie: movieList[index]),
                  );
                },
              ),
            ],
          )
        : Center(
            child: Container(
              padding: const EdgeInsets.symmetric(
                  horizontal: MARGIN_MEDIUM_2, vertical: MARGIN_MEDIUM_2),
              child: CircularProgressIndicator(),
            ),
          );
  }
}

class SearchFieldView extends StatelessWidget {
  final Function(String) onChanged;

  SearchFieldView({required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: MARGIN_MEDIUM_2),
      padding: const EdgeInsets.only(bottom: MARGIN_MEDIUM_2),
      child: TextField(
        onChanged: (value) {
          onChanged(value);
        },
        cursorColor: PLAY_BUTTON_COLOR,
        style: const TextStyle(
          color: Colors.white,
        ),
        decoration: const InputDecoration(
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: PLAY_BUTTON_COLOR),
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: PLAY_BUTTON_COLOR),
            ),
            hintText: HINT_TEXT_SEARCH_MOVIES,
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
      padding: const EdgeInsets.only(
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
            CategoryTabView(title: LABEL_NOW_PLAYING_MOVIES),
            CategoryTabView(title: LABEL_POPULAR_MOVIES),
            CategoryTabView(title: LABEL_SEARCH_MOVIES),
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
        style: const TextStyle(
          height: 1.3,
        ),
      ),
    );
  }
}
