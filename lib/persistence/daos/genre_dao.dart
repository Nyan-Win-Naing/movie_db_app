import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:movie_db_app/data/vos/genre_vo.dart';
import 'package:movie_db_app/persistence/hive_constants.dart';

class GenreDao {
  static final GenreDao _singleton = GenreDao._internal();

  factory GenreDao() {
    return _singleton;
  }

  GenreDao._internal();

  Box<GenreVO> getGenreBox() {
    return Hive.box<GenreVO>(BOX_NAME_GENRE_VO);
  }

  void saveAllGenres(List<GenreVO>? genreList) async {
    Map<int, GenreVO> genreMap = Map.fromIterable(
      genreList ?? [],
      key: (genre) => genre.id,
      value: (genre) => genre,
    );
    await getGenreBox().putAll(genreMap);
  }

  List<GenreVO> getAllGenres() {
    return getGenreBox().values.toList();
  }

  /// Reactive Programming
  Stream<void> getAllGenresEventStream() {
    return getGenreBox().watch();
  }

  Stream<List<GenreVO>> getAllGenresStream() {
    return Stream.value(getAllGenres());
  }

  List<GenreVO> getAllGenresReactive() {
    if(getAllGenres() != null && getAllGenres().isNotEmpty) {
      return getAllGenres();
    } else {
      return [];
    }
  }
}
