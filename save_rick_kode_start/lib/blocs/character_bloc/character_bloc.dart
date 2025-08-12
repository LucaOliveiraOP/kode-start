import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:save_rick_kode_start/data/repository.dart';
import 'character_event.dart';
import 'character_state.dart';
import '../../models/character.dart';

/// Bloc responsável por gerenciar o estado dos personagens,
/// incluindo o carregamento inicial e a busca por nome.
class CharacterBloc extends Bloc<CharacterEvent, CharacterState> {
  final CharacterRepository repository;

  /// Lista interna contendo todos os personagens carregados.
  /// Usada para filtrar personagens durante a busca, tornando a busca instântanea.
  List<Character> _allCharacters = [];

  CharacterBloc({required this.repository}) : super(CharactersInitial()) {
    on<LoadCharacters>(_onLoadCharacters);
    on<SearchCharacters>(_onSearchCharacters);
  }

  /// Manipula o carregamento inicial dos personagens.
  /// Busca todos os personagens da API, armazena internamente,
  /// e emite o estado [CharactersLoaded] com a lista completa.
  Future<void> _onLoadCharacters(
    LoadCharacters event,
    Emitter<CharacterState> emit,
  ) async {
    emit(CharactersLoading());
    try {
      final characters = await repository.fetchAllCharacters();
      _allCharacters = characters;
      emit(CharactersLoaded(characters));
    } catch (_) {
      emit(CharactersError("Erro ao carregar os personagens"));
    }
  }

  /// Manipula a busca de personagens pelo nome.
  /// Filtra a lista interna [_allCharacters] para aqueles
  /// cujos nomes contêm a consulta de busca.
  /// Emite [CharactersLoaded] com a lista filtrada.
  void _onSearchCharacters(
    SearchCharacters event,
    Emitter<CharacterState> emit,
  ) {
    final query = event.query.toLowerCase();

    final filteredCharacters = _allCharacters.where((character) {
      return character.name.toLowerCase().contains(query);
    }).toList();

    emit(CharactersLoaded(filteredCharacters));
  }
}
