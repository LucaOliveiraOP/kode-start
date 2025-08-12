import 'package:equatable/equatable.dart';
import '../../models/character.dart';

/// Classe base para todos os eventos relacionados a personagens.
abstract class CharacterEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

/// Evento para carregar todos os personagens do repositório.
class LoadCharacters extends CharacterEvent {}

/// Evento para selecionar um personagem específico.
class SelectCharacter extends CharacterEvent {
  /// O personagem que foi selecionado.
  final Character character;

  SelectCharacter(this.character);

  @override
  List<Object?> get props => [character];
}

/// Evento para buscar personagens por meio de uma string de consulta.
class SearchCharacters extends CharacterEvent {
  /// O texto da consulta de busca.
  final String query;

  SearchCharacters(this.query);

  @override
  List<Object?> get props => [query];
}

class ClearSearch extends CharacterEvent {}
