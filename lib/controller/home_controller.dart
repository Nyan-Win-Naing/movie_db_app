import 'package:flutter/widgets.dart';
import 'package:get/state_manager.dart';
import 'package:movie_db_app/data/models/movie_model.dart';
import 'package:movie_db_app/data/models/movie_model_impl.dart';
import 'package:movie_db_app/data/vos/genre_vo.dart';
import 'package:movie_db_app/data/vos/movie_vo.dart';

class HomeController extends GetxController {
  /// States
  RxList<MovieVO> nowPlayingMovies = <MovieVO>[].obs;
  RxList<MovieVO> popularMovies = <MovieVO>[].obs;
  RxList<MovieVO> searchMovies = <MovieVO>[].obs;
  RxInt tabIndex = 0.obs;
  int pageForNowPlayingMovies = 1;
  int pageForPopularMovies = 1;
  int pageForSearchMovies = 1;

  /// Models
  MovieModel mMovieModel = MovieModelImpl();

  HomeController() {
    mMovieModel.getNowPlayingMoviesFromDatabase().listen((nowPlayingMovies) {
      this.nowPlayingMovies.assignAll(nowPlayingMovies);
    }).onError((error) {
      debugPrint(error.toString());
    });

    mMovieModel.getPopularMoviesFromDatabase().listen((popularMovies) {
      this.popularMovies.assignAll(popularMovies);
    }).onError((error) {
      debugPrint(error.toString());
    });

    initializeSearchMovies();
  }

  void initializeSearchMovies() {
    mMovieModel.getTopRatedMovies(1).then((topRatedMovies) {
      searchMovies.assignAll(topRatedMovies ?? []);
    }).catchError((error) {
      debugPrint(error.toString());
    });
  }

  void onTapTab(int tabIndex) {
    this.tabIndex(tabIndex);
  }

  void onScrollEndReached() {
    if(tabIndex.value == 0) {
      pageForNowPlayingMovies += 1;
      mMovieModel.getNowPlayingMovies(pageForNowPlayingMovies);
    } else if(tabIndex.value == 1) {
      pageForPopularMovies += 1;
      mMovieModel.getPopularMovies(pageForPopularMovies);
    }
  }

  void onSearchMovies(String keyword) {
    if(keyword.isNotEmpty) {
      mMovieModel.searchMovies(keyword).then((searchedMovies) {
        searchMovies.assignAll(searchedMovies ?? []);
      }).catchError((error) {
        debugPrint(error.toString());
      });
    } else {
      initializeSearchMovies();
    }
  }
}