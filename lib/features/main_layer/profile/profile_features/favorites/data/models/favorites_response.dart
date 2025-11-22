/// message : "favourites fetched successfully"
/// data : [{"movieId":"movieId","name":"test","rating":2.4,"imageURL":"https//imagelink","year":"2002"},{"movieId":"movieId2","name":"tes2t","rating":2.4,"imageURL":"https//imagelink2","year":"20022"}]

class FavoritesResponse {
  FavoritesResponse({
      this.message, 
      this.data,});

  FavoritesResponse.fromJson(dynamic json) {
    message = json['message'];
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data?.add(FavMovie.fromJson(v));
      });
    }
  }
  String? message;
  List<FavMovie>? data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['message'] = message;
    if (data != null) {
      map['data'] = data?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// movieId : "movieId"
/// name : "test"
/// rating : 2.4
/// imageURL : "https//imagelink"
/// year : "2002"

class FavMovie {
  FavMovie({
      this.movieId, 
      this.name, 
      this.rating, 
      this.imageURL, 
      this.year,});

  FavMovie.fromJson(dynamic json) {
    movieId = json['movieId'];
    name = json['name'];
    rating = json['rating'];
    imageURL = json['imageURL'];
    year = json['year'];
  }
  String? movieId;
  String? name;
  double? rating;
  String? imageURL;
  String? year;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['movieId'] = movieId;
    map['name'] = name;
    map['rating'] = rating;
    map['imageURL'] = imageURL;
    map['year'] = year;
    return map;
  }

}