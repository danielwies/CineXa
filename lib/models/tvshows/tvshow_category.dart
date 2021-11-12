class TvShow {
  TvShow({
    this.page,
    this.results,
    this.totalResults,
    this.totalPages,
  });

  int? page;
  List<Result>? results;
  int? totalResults;
  int? totalPages;

  factory TvShow.fromJson(Map<String, dynamic> json) => TvShow(
        page: json["page"],
        results:
            List<Result>.from(json["results"].map((x) => Result.fromJson(x))),
        totalResults: json["total_results"],
        totalPages: json["total_pages"],
      );

  Map<String, dynamic> toJson() => {
        "page": page,
        "results": List<dynamic>.from(results!.map((x) => x.toJson())),
        "total_results": totalResults,
        "total_pages": totalPages,
      };
}

class Result {
  Result({
    this.posterPath,
    this.popularity,
    this.id,
    this.backdropPath,
    this.voteAverage,
    this.overview,
    this.firstAirDate,
    this.originCountry,
    this.genreIds,
    this.originalLanguage,
    this.voteCount,
    this.name,
    this.originalName,
  });

  String? posterPath;
  double? popularity;
  int? id;
  String? backdropPath;
  double? voteAverage;
  String? overview;
  DateTime? firstAirDate;
  List<OriginCountry>? originCountry;
  List<int>? genreIds;
  OriginalLanguage? originalLanguage;
  int? voteCount;
  String? name;
  String? originalName;

  factory Result.fromJson(Map<String, dynamic> json) => Result(
        posterPath: json["poster_path"],
        popularity: json["popularity"].toDouble(),
        id: json["id"],
        backdropPath: json["backdrop_path"],
        voteAverage: json["vote_average"].toDouble(),
        overview: json["overview"],
        firstAirDate: DateTime.parse(json["first_air_date"]),
        originCountry: List<OriginCountry>.from(
            json["origin_country"].map((x) => originCountryValues.map[x])),
        genreIds: List<int>.from(json["genre_ids"].map((x) => x)),
        originalLanguage:
            originalLanguageValues.map[json["original_language"]]!,
        voteCount: json["vote_count"],
        name: json["name"],
        originalName: json["original_name"],
      );

  Map<String, dynamic> toJson() => {
        "poster_path": posterPath,
        "popularity": popularity,
        "id": id,
        "backdrop_path": backdropPath,
        "vote_average": voteAverage,
        "overview": overview,
        "first_air_date":
            "${firstAirDate!.year.toString().padLeft(4, '0')}-${firstAirDate!.month.toString().padLeft(2, '0')}-${firstAirDate!.day.toString().padLeft(2, '0')}",
        "origin_country": List<dynamic>.from(
            originCountry!.map((x) => originCountryValues.reverse[x])),
        "genre_ids": List<dynamic>.from(genreIds!.map((x) => x)),
        "original_language": originalLanguageValues.reverse[originalLanguage],
        "vote_count": voteCount,
        "name": name,
        "original_name": originalName,
      };
}

enum OriginCountry { US, GB, JP }

final originCountryValues = EnumValues(
    {"GB": OriginCountry.GB, "JP": OriginCountry.JP, "US": OriginCountry.US});

enum OriginalLanguage { EN, JA }

final originalLanguageValues =
    EnumValues({"en": OriginalLanguage.EN, "ja": OriginalLanguage.JA});

class EnumValues<T> {
  Map<String, T> map;
  Map<T, String>? reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    if (reverseMap == null) {
      reverseMap = map.map((k, v) => new MapEntry(v, k));
    }
    return reverseMap!;
  }
}
