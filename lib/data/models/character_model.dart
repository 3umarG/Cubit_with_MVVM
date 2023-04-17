class CharacterModel {
  final int id;
  final String name;
  final String status;
  final String species;
  final String gender;
  final String imageUrl;
  final String url;
  final String created;

  CharacterModel({
    required this.created,
    required this.species,
    required this.id,
    required this.name,
    required this.status,
    required this.gender,
    required this.imageUrl,
    required this.url,
  });

  factory CharacterModel.fromJson(Map<String, dynamic> json) => CharacterModel(
        id: json['id'],
        name: json['name'],
        status: json['status'],
        gender: json['gender'],
        imageUrl: json['image'],
        url: json['url'],
        species: json['species']??"Null",
        created: json['created'],
      );
}
