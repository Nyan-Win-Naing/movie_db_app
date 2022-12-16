import 'package:movie_db_app/data/vos/actor_vo.dart';
import 'package:movie_db_app/data/vos/genre_vo.dart';
import 'package:movie_db_app/data/vos/movie_vo.dart';

abstract class MovieModel {
  // Network
  void getNowPlayingMovies(int page);
  void getPopularMovies(int page);
  void getTopRatedMovies(int page);
  void getMovieDetails(int movieId, int tabIndex);
  Future<List<List<ActorVO>?>> getCreditsByMovie(int movieId);

  // Database
  Stream<List<MovieVO>> getNowPlayingMoviesFromDatabase();
  Stream<List<MovieVO>> getPopularMoviesFromDatabase();
  Stream<List<MovieVO>> getTopRatedMoviesFromDatabase();
  Stream<MovieVO?> getMovieDetailsFromDatabase(int movieId, int tabIndex);
}