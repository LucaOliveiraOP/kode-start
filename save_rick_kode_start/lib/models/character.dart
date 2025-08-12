/// Represents a character with detailed information from the Rick and Morty API.
class Character {
  /// Unique identifier of the character.
  final int id;

  /// Name of the character.
  final String name;

  /// Current status of the character (e.g., Alive, Dead, Unknown).
  final String status;

  /// Species of the character (e.g., Human, Alien).
  final String species;

  /// Type or variant of the character (can be empty).
  final String type;

  /// Gender of the character (e.g., Male, Female, Genderless, Unknown).
  final String gender;

  /// Name of the character's origin location.
  final String originName;

  /// API URL of the character's origin location.
  final String originUrl;

  /// Name of the character's current location.
  final String locationName;

  /// API URL of the character's current location.
  final String locationUrl;

  /// URL to the character's image.
  final String image;

  /// List of episode URLs the character appears in.
  final List<String> episode;

  /// Creates a new [Character] instance with all fields.
  Character({
    required this.id,
    required this.name,
    required this.status,
    required this.species,
    required this.type,
    required this.gender,
    required this.originName,
    required this.originUrl,
    required this.locationName,
    required this.locationUrl,
    required this.image,
    required this.episode,
  });

  /// Creates a [Character] instance from a JSON map.
  factory Character.fromJson(Map<String, dynamic> json) {
    return Character(
      id: json['id'],
      name: json['name'],
      status: json['status'],
      species: json['species'],
      type: json['type'],
      gender: json['gender'],
      originName: json['origin']['name'],
      originUrl: json['origin']['url'],
      locationName: json['location']['name'],
      locationUrl: json['location']['url'],
      image: json['image'],
      episode: List<String>.from(json['episode']),
    );
  }
}
