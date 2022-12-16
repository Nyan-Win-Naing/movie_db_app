import 'package:hive/hive.dart';
import 'package:movie_db_app/data/vos/movie_vo.dart';
import 'package:movie_db_app/persistence/hive_constants.dart';

class MovieDao {
  static final MovieDao _singleton = MovieDao._internal();

  factory MovieDao() {
    return _singleton;
  }

  MovieDao._internal();

  Box<MovieVO> getMovieBox() {
    return Hive.box<MovieVO>(BOX_NAME_MOVIE_VO);
  }

  void saveMovies(List<MovieVO>? movies) async {
    Map<int, MovieVO> movieMap = Map.fromIterable(
      movies ?? [],
      key: (movie) => movie.id,
      value: (movie) => movie,
    );
    await getMovieBox().putAll(movieMap);
  }

  void saveSingleMovie(MovieVO? movie) async {
    await getMovieBox().put(movie!.id, movie);
  }

  List<MovieVO> getAllMovies() {
    return getMovieBox().values.toList();
  }

  MovieVO? getMovieById(int movieId) {
    return getMovieBox().get(movieId);
  }

  /// Reactive Programming
  Stream<void> getAllMoviesEventStream() {
    return getMovieBox().watch();
  }

  @override
  Stream<List<MovieVO>> getNowPlayingMoviesStream() {
    return Stream.value(getAllMovies()
        .where((element) => element.isNowPlaying ?? false)
        .toList());
  }

  @override
  Stream<List<MovieVO>> getPopularMoviesStream() {
    return Stream.value(
      getAllMovies().where((element) => element.isPopular ?? false).toList(),
    );
  }

  @override
  Stream<List<MovieVO>> getTopRatedMoviesStream() {
    return Stream.value(getAllMovies()
        .where((element) => element.isTopRated ?? false)
        .toList());
  }

  Stream<MovieVO?> getMovieByIdStream(int movieId) {
    return Stream.value(getMovieById(movieId));
  }

  /// For Reactive
  List<MovieVO> getNowPlayingMoviesReactive() {
    if (getAllMovies() != null && (getAllMovies().isNotEmpty)) {
      print("Movies are present....");
      return getAllMovies()
          .where((element) => element.isNowPlaying ?? false)
          .toList();
    } else {
      print("No Movies......");
      return [];
    }
  }

  List<MovieVO> getPopularMoviesReactive() {
    if (getAllMovies() != null && (getAllMovies().isNotEmpty)) {
      return getAllMovies()
          .where((element) => element.isPopular ?? false)
          .toList();
    } else {
      return [];
    }
  }

  List<MovieVO> getTopRatedMoviesReactive() {
    if (getAllMovies() != null && (getAllMovies().isNotEmpty)) {
      return getAllMovies()
          .where((element) => element.isTopRated ?? false)
          .toList();
    } else {
      return [];
    }
  }

  MovieVO? getMovieByIdReactive(int movieId) {
    return getMovieById(movieId);
  }
}
