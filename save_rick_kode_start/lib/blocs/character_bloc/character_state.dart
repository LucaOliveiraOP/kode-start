import 'package:equatable/equatable.dart';
import '../../models/character.dart';

/// Classe base para todos os estados relacionados aos personagens.
abstract class CharacterState extends Equatable {
  @override
  List<Object?> get props => [];
}

/// Estado inicial antes de qualquer dado de personagem ser carregado.
class CharactersInitial extends CharacterState {}

/// Estado quando os personagens estão sendo carregados.
class CharactersLoading extends CharacterState {}

/// Estado quando os personagens foram carregados com sucesso.
class CharactersLoaded extends CharacterState {
  /// Lista de personagens carregados.
  final List<Character> characters;

  CharactersLoaded(this.characters);

  @override
  List<Object?> get props => [characters];
}

/// Estado quando um personagem específico é selecionado.
class CharacterSelected extends CharacterState {
  /// O personagem selecionado.
  final Character character;

  CharacterSelected(this.character);

  @override
  List<Object?> get props => [character];
}

/// Estado quando ocorre um erro ao carregar os personagens.
class CharactersError extends CharacterState {
  /// Mensagem de erro descrevendo o que deu errado.
  final String message;

  CharactersError(this.message);

  @override
  List<Object?> get props => [message];
}

class CharactersEmpty extends CharacterState {}
