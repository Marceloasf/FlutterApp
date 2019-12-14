class GameModel {
  int id;
  String slug;
  String name;
  String nameOriginal;
  String description;
  int metacritic;
  String released;
  bool tba;
  String updated;
  String backgroundImage;
  String backgroundImageAdditional;
  String website;
  double rating;
  int ratingTop;

  GameModel({
    this.id,
    this.slug,
    this.name,
    this.nameOriginal,
    this.description,
    this.metacritic,
    this.released,
    this.tba,
    this.updated,
    this.backgroundImage,
    this.backgroundImageAdditional,
    this.website,
    this.rating,
    this.ratingTop,
  });

  GameModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    slug = json['slug'];
    name = json['name'];
    nameOriginal = json['name_original'];
    description = json['description'];
    metacritic = json['metacritic'];
    released = json['released'];
    tba = json['tba'];
    updated = json['updated'];
    backgroundImage = json['background_image'];
    backgroundImageAdditional = json['background_image_additional'];
    website = json['website'];
    rating = json['rating'];
    ratingTop = json['rating_top'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['slug'] = this.slug;
    data['name'] = this.name;
    data['name_original'] = this.nameOriginal;
    data['description'] = this.description;
    data['metacritic'] = this.metacritic;
    data['released'] = this.released;
    data['tba'] = this.tba;
    data['updated'] = this.updated;
    data['background_image'] = this.backgroundImage;
    data['background_image_additional'] = this.backgroundImageAdditional;
    data['website'] = this.website;
    data['rating'] = this.rating;
    data['rating_top'] = this.ratingTop;
    return data;
  }
}
