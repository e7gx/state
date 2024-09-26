class Location {
  String name;
  String url;

  Location({
    required this.name,
    required this.url,
  });

  /// Factory constructor that creates a `Location` instance from a JSON map.
  ///
  /// The [json] parameter is a `Map<String, dynamic>` where the keys are strings
  /// representing the JSON field names and the values are dynamic, meaning they
  /// can be of any type. This allows the method to parse the JSON data and
  /// initialize the `Location` object accordingly.
  factory Location.fromJson(Map<String, dynamic> json) {
    return Location(
      name: json['name'],
      url: json['url'],
    );
  }
}

class CharactersModel {
  int id;
  String name;
  String status;
  String species;
  String gender;
  String? type; // Nullable type
  String image;
  List<String> episode;
  String url;
  DateTime created;
  Location origin; // Nested object for origin
  Location location; // Nested object for location

  CharactersModel({
    required this.id,
    required this.name,
    required this.status,
    required this.species,
    required this.gender,
    this.type,
    required this.image,
    required this.episode,
    required this.url,
    required this.created,
    required this.origin,
    required this.location,
  });

  factory CharactersModel.fromJson(Map<String, dynamic> json) {
    return CharactersModel(
      id: json['id'],
      name: json['name'],
      status: json['status'],
      species: json['species'],
      gender: json['gender'],
      type: json['type'] == "" ? null : json['type'],
      image: json['image'],
      episode: List<String>.from(json['episode']),
      url: json['url'],
      created: DateTime.parse(json['created']),
      origin: Location.fromJson(json['origin']), // Parsing nested object
      location: Location.fromJson(json['location']), // Parsing nested object
    );
  }
}
