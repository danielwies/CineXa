class MovieCategory {
  bool? adult;
  String? backdropPath;
  List<int>? genreIds;
  int? id;
  String? originalLanguage;
  String? originalTitle;
  String overview;
  double? popularity;
  String posterPath;
  DateTime? releaseDate;
  String title;
  bool? video;
  String? voteAverage;
  int? voteCount;

  MovieCategory({
    this.adult,
    this.backdropPath,
    this.genreIds,
    this.id,
    this.originalLanguage,
    this.originalTitle,
    required this.overview,
    this.popularity,
    required this.posterPath,
    this.releaseDate,
    required this.title,
    this.video,
    this.voteAverage,
    this.voteCount,
  });

  factory MovieCategory.fromJson(Map<String, dynamic> json) => MovieCategory(
        adult: json['adult'],
        backdropPath: json['backdrop_path'],
        genreIds: json['genre_ids'].cast<int>(),
        id: json['id'],
        originalLanguage: json['original_language'],
        originalTitle: json['original_title'],
        overview: json['overview'],
        popularity: json['popularity'],
        posterPath: json['poster_path'],
        releaseDate: DateTime.parse(json["release_date"]),
        title: json['title'],
        video: json['video'],
        voteAverage: json['vote_average'].toString(),
        voteCount: json['vote_count'],
      );

  Map<String, dynamic> toJson() => {
        "adult": this.adult,
        "backdrop_path": backdropPath,
        "genre_ids": List<dynamic>.from(genreIds!.map((x) => x)),
        "id": id,
        "original_language": originalLanguage,
        "original_title": originalTitle,
        "overview": overview,
        "popularity": popularity,
        "poster_path": posterPath,
        "release_date":
            "${releaseDate!.year.toString().padLeft(4, '0')}-${releaseDate!.month.toString().padLeft(2, '0')}-${releaseDate!.day.toString().padLeft(2, '0')}",
        "title": title,
        "video": video,
        "vote_average": voteAverage,
        "vote_count": voteCount,
      };
}
