import 'package:hive/hive.dart';
import 'package:intl/intl.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:movie_db_app/data/vos/collection_vo.dart';
import 'package:movie_db_app/data/vos/genre_vo.dart';
import 'package:movie_db_app/data/vos/production_company_vo.dart';
import 'package:movie_db_app/data/vos/production_country_vo.dart';
import 'package:movie_db_app/data/vos/spoken_language_vo.dart';
import 'package:movie_db_app/persistence/hive_constants.dart';

part 'movie_vo.g.dart';

@JsonSerializable()
@HiveType(typeId: HYPE_TYPE_ID_MOVIE_VO, adapterName: "MovieVOAdapter")
class MovieVO {
  @JsonKey(name: "adult")
  @HiveField(0)
  bool? adult;

  @JsonKey(name: "backdrop_path")
  @HiveField(1)
  String? backDropPath;

  @JsonKey(name: "genre_ids")
  @HiveField(2)
  List<int>? genreIds;

  @JsonKey(name: "id")
  @HiveField(3)
  int? id;

  @JsonKey(name: "original_language")
  @HiveField(4)
  String? originalLanguage;

  @JsonKey(name: "original_title")
  @HiveField(5)
  String? originalTitle;

  @JsonKey(name: "overview")
  @HiveField(6)
  String? overview;

  @JsonKey(name: "popularity")
  @HiveField(7)
  double? popularity;

  @JsonKey(name: "poster_path")
  @HiveField(8)
  String? posterPath;

  @JsonKey(name: "release_date")
  @HiveField(9)
  String? releaseDate;

  @JsonKey(name: "title")
  @HiveField(10)
  String? title;

  @JsonKey(name: "video")
  @HiveField(11)
  bool? video;

  @JsonKey(name: "vote_average")
  @HiveField(12)
  double? voteAverage;

  @JsonKey(name: "vote_count")
  @HiveField(13)
  int? voteCount;

  @JsonKey(name: "belongs_to_collection")
  @HiveField(14)
  CollectionVO? belongsToCollection;

  @JsonKey(name: "budget")
  @HiveField(15)
  double? budget;

  @JsonKey(name: "genres")
  @HiveField(16)
  List<GenreVO>? genres;

  @JsonKey(name: "homepage")
  @HiveField(17)
  String? homePage;

  @JsonKey(name: "imdb_id")
  @HiveField(18)
  String? imdbId;

  @JsonKey(name: "production_companies")
  @HiveField(19)
  List<ProductionCompanyVO>? productionCompanies;

  @JsonKey(name: "production_countries")
  @HiveField(20)
  List<ProductionCountryVO>? productionCountries;

  @JsonKey(name: "revenue")
  @HiveField(21)
  int? revenue;

  @JsonKey(name: "runtime")
  @HiveField(22)
  int? runTime;

  @JsonKey(name: "spoken_languages")
  @HiveField(23)
  List<SpokenLanguageVO>? spokenLanguages;

  @JsonKey(name: "status")
  @HiveField(24)
  String? status;

  @JsonKey(name: "tagline")
  @HiveField(25)
  String? tagLine;

  @HiveField(26)
  bool? isNowPlaying;

  @HiveField(27)
  bool? isPopular;

  @HiveField(28)
  bool? isTopRated;

  MovieVO({
    this.adult,
    this.backDropPath,
    this.genreIds,
    this.id,
    this.originalLanguage,
    this.originalTitle,
    this.overview,
    this.popularity,
    this.posterPath,
    this.releaseDate,
    this.title,
    this.video,
    this.voteAverage,
    this.voteCount,
    this.belongsToCollection,
    this.budget,
    this.genres,
    this.homePage,
    this.imdbId,
    this.productionCompanies,
    this.productionCountries,
    this.revenue,
    this.runTime,
    this.spokenLanguages,
    this.status,
    this.tagLine,
    this.isPopular,
    this.isNowPlaying,
    this.isTopRated,
  });

  factory MovieVO.fromJson(Map<String, dynamic> json) =>
      _$MovieVOFromJson(json);

  Map<String, dynamic> toJson() => _$MovieVOToJson(this);

  @override
  String toString() {
    return 'MovieVO{title: $title}';
  }

  double getRating() {
    double rating = (voteAverage ?? 0) / 2;
    return rating;
  }

  String getVoteAverage() {
    return voteAverage?.toStringAsFixed(1) ?? "";
  }

  String getFormattedReleaseDate() {
    DateTime? releaseDate = DateTime.tryParse(this.releaseDate ?? "");
    return DateFormat("dd/MM/yyyy").format(releaseDate ?? DateTime.now());
  }

  String getFormattedMovieRunTime() {
    int hour = (runTime ?? 0) ~/ 60;
    int minutes = (runTime ?? 0) % 60;
    return "${hour}h ${minutes}min";
  }

  String getGenresWithCommaSeparatedValue() {
    return genres?.map((genre) => genre.name ?? "").toList().join(",") ?? "";
  }

  String getProductionCountriesWithCommaSeparated() {
    return productionCountries
        ?.map((productionCountry) => productionCountry.name ?? "")
        .toList()
        .join(",") ?? "";
  }
}
