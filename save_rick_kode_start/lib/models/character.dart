/// Representa um personagem com informações detalhadas da API Rick and Morty.
class Character {
  /// Identificador único do personagem.
  final int id;

  /// Nome do personagem.
  final String name;

  /// Estado atual do personagem (ex: Vivo, Morto, Desconhecido).
  final String status;

  /// Espécie do personagem (ex: Humano, Alienígena).
  final String species;

  /// Tipo ou variante do personagem (pode ser vazio).
  final String type;

  /// Gênero do personagem.
  final String gender;

  /// Nome da localização de origem do personagem.
  final String originName;

  /// URL da API da localização de origem.
  final String originUrl;

  /// Nome da localização atual do personagem.
  final String locationName;

  /// URL da API da localização atual.
  final String locationUrl;

  /// URL da imagem do personagem.
  final String image;

  /// Lista de URLs dos episódios em que o personagem aparece.
  final List<String> episode;

  /// Cria uma nova instância de [Character] com todos os campos.
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

  /// Cria uma instância de [Character] a partir de um mapa JSON.
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
