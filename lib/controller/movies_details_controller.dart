import 'package:flutter/widgets.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/state_manager.dart';
import 'package:movie_db_app/data/models/movie_model.dart';
import 'package:movie_db_app/data/models/movie_model_impl.dart';
import 'package:movie_db_app/data/vos/actor_vo.dart';
import 'package:movie_db_app/data/vos/movie_vo.dart';

class MovieDetailsController extends GetxController {
  /// States
  Rx<MovieVO> mMovieDetail = MovieVO().obs;
  RxList<ActorVO> mActorList = <ActorVO>[].obs;
  RxList<ActorVO> mCreatorList = <ActorVO>[].obs;

  /// Model
  MovieModel mMovieModel = MovieModelImpl();

  void fetchMovieDetails(int movieId, int tabIndex) {
    /// Movie Detail From Database
    mMovieModel.getMovieDetailsFromDatabase(movieId, tabIndex).listen((movie) {
      mMovieDetail(movie);
    }).onError((error) {
      debugPrint(error.toString());
    });

    /// Credits
    mMovieModel.getCreditsByMovie(movieId).then((castAndCrews) {
      mActorList.assignAll(castAndCrews.first ?? []);
      mCreatorList.assignAll(castAndCrews.last ?? []);
    }).catchError((error) {
      debugPrint(error.toString());
    });
  }
}