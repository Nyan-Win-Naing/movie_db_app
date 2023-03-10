import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:movie_db_app/data/vos/movie_vo.dart';
import 'package:movie_db_app/persistence/hive_constants.dart';

part 'actor_vo.g.dart';

@JsonSerializable()
@HiveType(typeId: HIVE_TYPE_ID_ACTOR_VO, adapterName: "ActorVOAdapter")
class ActorVO {
  @JsonKey(name: "adult")
  @HiveField(0)
  bool? adult;

  @JsonKey(name: "id")
  @HiveField(1)
  int? id;

  @JsonKey(name: "known_for")
  @HiveField(2)
  List<MovieVO>? knownFor;

  @JsonKey(name: "popularity")
  @HiveField(3)
  double? popularity;

  @JsonKey(name: "name")
  @HiveField(4)
  String? name;

  @JsonKey(name: "profile_path")
  @HiveField(5)
  String? profilePath;

  @JsonKey(name: "known_for_department")
  @HiveField(6)
  String? knownForDepartment;

  @JsonKey(name: "original_name")
  @HiveField(7)
  String? originalName;

  @JsonKey(name: "cast_id")
  @HiveField(8)
  int? castId;

  @JsonKey(name: "character")
  @HiveField(9)
  String? character;

  @JsonKey(name: "credit_id")
  @HiveField(10)
  String? creditId;

  @JsonKey(name: "order")
  @HiveField(11)
  int? order;

  ActorVO({
    this.adult,
    this.id,
    this.knownFor,
    this.popularity,
    this.name,
    this.profilePath,
    this.knownForDepartment,
    this.originalName,
    this.castId,
    this.character,
    this.creditId,
    this.order,
  });

  factory ActorVO.fromJson(Map<String, dynamic> json) =>
      _$ActorVOFromJson(json);

  Map<String, dynamic> toJson() => _$ActorVOToJson(this);


  @override
  String toString() {
    return 'ActorVO{adult: $adult, id: $id, knownFor: $knownFor, popularity: $popularity, name: $name, profilePath: $profilePath, knownForDepartment: $knownForDepartment, originalName: $originalName, castId: $castId, character: $character, creditId: $creditId, order: $order}';
  }

  // @override
  // bool operator ==(Object other) =>
  //     identical(this, other) ||
  //     other is ActorVO &&
  //         runtimeType == other.runtimeType &&
  //         adult == other.adult &&
  //         id == other.id &&
  //         knownFor == other.knownFor &&
  //         popularity == other.popularity &&
  //         name == other.name &&
  //         profilePath == other.profilePath &&
  //         knownForDepartment == other.knownForDepartment &&
  //         originalName == other.originalName &&
  //         castId == other.castId &&
  //         character == other.character &&
  //         creditId == other.creditId &&
  //         order == other.order;
  //
  // @override
  // int get hashCode =>
  //     adult.hashCode ^
  //     id.hashCode ^
  //     knownFor.hashCode ^
  //     popularity.hashCode ^
  //     name.hashCode ^
  //     profilePath.hashCode ^
  //     knownForDepartment.hashCode ^
  //     originalName.hashCode ^
  //     castId.hashCode ^
  //     character.hashCode ^
  //     creditId.hashCode ^
  //     order.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is ActorVO &&
              runtimeType == other.runtimeType &&
              id == other.id &&
              name == other.name;

  @override
  int get hashCode => id.hashCode ^ name.hashCode;
}