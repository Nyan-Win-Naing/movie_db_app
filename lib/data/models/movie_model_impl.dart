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
  Future<MovieVO?> getMovieDetails(int movieId, int tabIndex) {
    return mDataAgent.getMovieDetails(movieId).then((movie) async {
      movie?.isNowPlaying = (tabIndex == 0);
      movie?.isPopular = tabIndex == 1;
      movie?.isTopRated = tabIndex == 2;
      mMovieDao.saveSingleMovie(movie);
      return Future.value(movie);
    });
  }

  @override
  Future<MovieVO?> getMovieDetailsFromDatabase(int movieId) {
    return Future.value(mMovieDao.getMovieById(movieId));
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
  Future<List<MovieVO>?> getTopRatedMovies(int page) {
    return mDataAgent.getTopRatedMovies(page);
  }

  @override
  Future<List<MovieVO>?> searchMovies(String searchKeyword) {
    return mDataAgent.getSearchMovies(searchKeyword);
  }

  @override
  void getAllGenres() {
    mDataAgent.getGenres().then((genreList) async {
      mGenreDao.saveAllGenres(genreList ?? []);
    });
  }

  @override
  Stream<List<GenreVO>> getAllGenresFromDatabase() {
    getAllGenres();
    return mGenreDao
        .getAllGenresEventStream()
        .startWith(mGenreDao.getAllGenresStream())
        .map((event) => mGenreDao.getAllGenresReactive());
  }

  @override
  Future<List<MovieVO>?> getMoviesByGenre(int genreId) {
    return mDataAgent.getMoviesByGenre(genreId);
  }
}
