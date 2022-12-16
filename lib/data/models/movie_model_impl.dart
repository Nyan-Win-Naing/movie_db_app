import 'package:flutter/foundation.dart';
import 'package:movie_db_app/data/models/movie_model.dart';
import 'package:movie_db_app/data/vos/actor_vo.dart';
import 'package:movie_db_app/data/vos/genre_vo.dart';
import 'package:movie_db_app/data/vos/movie_vo.dart';
import 'package:movie_db_app/network/dataagents/movie_data_agent.dart';
import 'package:movie_db_app/network/dataagents/retrofit_data_agent_impl.dart';
import 'package:movie_db_app/persistence/daos/actor_dao.dart';
import 'package:movie_db_app/persistence/daos/genre_dao.dart';
import 'package:movie_db_app/persistence/daos/movie_dao.dart';
import 'package:stream_transform/stream_transform.dart';

class MovieModelImpl extends MovieModel {
  static final MovieModelImpl _singleton = MovieModelImpl._internal();

  factory MovieModelImpl() {
    return _singleton;
  }

  MovieModelImpl._internal();

  MovieDataAgent mDataAgent = RetrofitDataAgentImpl();

  /// Daos
  MovieDao mMovieDao = MovieDao();
  GenreDao mGenreDao = GenreDao();
  ActorDao mActorDao = ActorDao();

  @override
  Future<List<List<ActorVO>?>> getCreditsByMovie(int movieId) {
    return mDataAgent.getCreditsByMovies(movieId);
  }

  @override
  void getMovieDetails(int movieId, int tabIndex) {
    mDataAgent.getMovieDetails(movieId).then((movie) async {
      movie?.isNowPlaying = (tabIndex == 0);
      movie?.isPopular = tabIndex == 1;
      movie?.isTopRated = tabIndex == 2;
      mMovieDao.saveSingleMovie(movie);
    });
  }

  @override
  Stream<MovieVO?> getMovieDetailsFromDatabase(int movieId, int tabIndex) {
    getMovieDetails(movieId, tabIndex);
    return mMovieDao
        .getAllMoviesEventStream()
        .startWith(mMovieDao.getMovieByIdStream(movieId))
        .map((event) => mMovieDao.getMovieByIdReactive(movieId));
  }

  @override
  void getNowPlayingMovies(int page) {
    mDataAgent.getNowPlayingMovies(page).then((movies) async {
      List<MovieVO>? nowPlayingMovies = movies?.map((movie) {
        movie.isNowPlaying = true;
        movie.isPopular = false;
        movie.isTopRated = false;
        return movie;
      }).toList();
      mMovieDao.saveMovies(nowPlayingMovies ?? []);
    });
  }

  @override
  Stream<List<MovieVO>> getNowPlayingMoviesFromDatabase() {
    getNowPlayingMovies(1);
    return mMovieDao
        .getAllMoviesEventStream()
        .startWith(mMovieDao.getNowPlayingMoviesStream())
        .map((event) => mMovieDao.getNowPlayingMoviesReactive());
  }

  @override
  void getPopularMovies(int page) {
    mDataAgent.getPopularMovies(page).then((movies) async {
      List<MovieVO>? popularMovies = movies?.map((movie) {
        movie.isNowPlaying = false;
        movie.isPopular = true;
        movie.isTopRated = false;
        return movie;
      }).toList();
      mMovieDao.saveMovies(popularMovies ?? []);
    });
  }

  @override
  Stream<List<MovieVO>> getPopularMoviesFromDatabase() {
    getPopularMovies(1);
    return mMovieDao
        .getAllMoviesEventStream()
        .startWith(mMovieDao.getPopularMoviesStream())
        .map((event) => mMovieDao.getPopularMoviesReactive());
  }

  @override
  void getTopRatedMovies(int page) {
    mDataAgent.getTopRatedMovies(page).then((movies) async {
      List<MovieVO>? topRatedMovies = movies?.map((movie) {
        movie.isNowPlaying = false;
        movie.isPopular = false;
        movie.isTopRated = true;
        return movie;
      }).toList();
      mMovieDao.saveMovies(topRatedMovies ?? []);
    });
  }

  @override
  Stream<List<MovieVO>> getTopRatedMoviesFromDatabase() {
    getTopRatedMovies(1);
    return mMovieDao
        .getAllMoviesEventStream()
        .startWith(mMovieDao.getTopRatedMoviesStream())
        .map((event) => mMovieDao.getTopRatedMoviesReactive());
  }
}
