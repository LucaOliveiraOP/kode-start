import 'package:dio/dio.dart';
import 'package:save_rick_kode_start/models/character.dart';

/// Repositório responsável por buscar os dados dos personagens
/// da API Rick and Morty.
class CharacterRepository {
  /// Cliente HTTP Dio usado para realizar as requisições.
  final Dio dio = Dio();

  /// URL base do endpoint de personagens da API Rick and Morty.
  final String baseUrl = "https://rickandmortyapi.com/api/character";

  /// Busca todos os personagens da API, lidando com paginação.
  ///
  /// Este método primeiro busca a primeira página para obter
  /// o número total de páginas e então busca todas as páginas
  /// sequencialmente, acumulando uma lista completa de objetos [Character].
  ///
  /// Retorna um [Future] que completa com uma lista de todos os personagens.
  Future<List<Character>> fetchAllCharacters() async {
    List<Character> allCharacters = [];

    // Busca a primeira página
    final response = await dio.get(baseUrl);
    final data = response.data;

    // Obtém a quantidade total de páginas da resposta
    int pages = data['info']['pages'];

    // Converte os personagens da primeira página em objetos Character
    allCharacters.addAll(
      (data['results'] as List)
          .map((json) => Character.fromJson(json))
          .toList(),
    );

    // Busca as demais páginas sequencialmente e acumula os personagens
    for (int page = 2; page <= pages; page++) {
      final resp = await dio.get("$baseUrl?page=$page");
      final results = resp.data['results'] as List;
      allCharacters.addAll(
        results.map((json) => Character.fromJson(json)).toList(),
      );
    }

    return allCharacters;
  }
}
