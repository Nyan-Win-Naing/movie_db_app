import 'package:flutter/widgets.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/state_manager.dart';
import 'package:movie_db_app/data/models/movie_model.dart';
import 'package:movie_db_app/data/models/movie_model_impl.dart';
import 'package:movie_db_app/data/vos/actor_vo.dart';
import 'package:movie_db_app/data/vos/genre_vo.dart';
import 'package:movie_db_app/data/vos/movie_vo.dart';

class MovieDetailsController extends GetxController {
  /// States
  Rx<MovieVO> mMovieDetail = MovieVO().obs;
  RxList<ActorVO> mActorList = <ActorVO>[].obs;
  RxList<ActorVO> mCreatorList = <ActorVO>[].obs;
  RxList<GenreVO> mGenreList = <GenreVO>[].obs;
  RxList<MovieVO> mMoviesByGenre = <MovieVO>[].obs;

  /// Model
  MovieModel mMovieModel = MovieModelImpl();

  void fetchMovieDetails(int movieId, int tabIndex) {
    /// Movie Detail
    mMovieModel.getMovieDetails(movieId, tabIndex).then((movie) {
      mMovieDetail(movie);
    }).catchError((error) {
      debugPrint(error.toString());
    });

    /// Movie Detail From Database
    mMovieModel.getMovieDetailsFromDatabase(movieId).then((movie) {
      mMovieDetail(movie);
    }).catchError((error) {
      debugPrint(error.toString());
    });

    /// Credits
    mMovieModel.getCreditsByMovie(movieId).then((castAndCrews) {
      mActorList.assignAll(castAndCrews.first ?? []);
      mCreatorList.assignAll(castAndCrews.last ?? []);
    }).catchError((error) {
      debugPrint(error.toString());
    });

    /// Get All Genres From Database
    mMovieModel.getAllGenresFromDatabase().listen((genres) {
      mGenreList.assignAll(genres);
      if(genres.isNotEmpty) {
        _getMoviesByGenreId(genres.first.id ?? 0);
      }
    }).onError((error) {
      debugPrint(error.toString());
    });
  }

  void _getMoviesByGenreId(int genreId) {
    mMovieModel.getMoviesByGenre(genreId).then((movies) {
      mMoviesByGenre.assignAll(movies ?? []);
    }).catchError((error) {
      debugPrint(error.toString());
    });
  }

  void onTapGenre(int genreId) {
    _getMoviesByGenreId(genreId);
  }
}