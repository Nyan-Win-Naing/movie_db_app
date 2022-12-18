import 'package:movie_db_app/data/vos/actor_vo.dart';
import 'package:movie_db_app/data/vos/genre_vo.dart';
import 'package:movie_db_app/data/vos/movie_vo.dart';

abstract class MovieModel {
  // Network
  void getNowPlayingMovies(int page);
  void getPopularMovies(int page);
  Future<List<MovieVO>?> getTopRatedMovies(int page);
  Future<MovieVO?> getMovieDetails(int movieId, int tabIndex);
  Future<List<List<ActorVO>?>> getCreditsByMovie(int movieId);
  Future<List<MovieVO>?> searchMovies(String searchKeyword);
  void getAllGenres();
  Future<List<MovieVO>?> getMoviesByGenre(int genreId);

  // Database
  Stream<List<MovieVO>> getNowPlayingMoviesFromDatabase();
  Stream<List<MovieVO>> getPopularMoviesFromDatabase();
  Future<MovieVO?> getMovieDetailsFromDatabase(int movieId);
  Stream<List<GenreVO>> getAllGenresFromDatabase();
}