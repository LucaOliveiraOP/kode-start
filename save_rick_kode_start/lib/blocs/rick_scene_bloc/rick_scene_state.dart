import 'package:equatable/equatable.dart';

/// Classe base abstrata para os estados possíveis da cena do Rick.
abstract class RickSceneState extends Equatable {
  const RickSceneState();

  @override
  List<Object?> get props => [];
}

/// Estado inicial da cena.
class RickSceneInitial extends RickSceneState {
  const RickSceneInitial();
}

/// Estado que representa Rick falando algo, geralmente disparando um áudio.
class RickSpeaking extends RickSceneState {
  /// Caminho do arquivo de áudio que Rick irá falar.
  final String message;

  const RickSpeaking(this.message);

  @override
  List<Object?> get props => [message];
}

/// Estado que indica que Rick ficou preso nos portais.
class LockedInPortals extends RickSceneState {
  const LockedInPortals();
}
