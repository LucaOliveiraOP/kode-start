import 'package:equatable/equatable.dart';

/// Classe base abstrata para todos os eventos relacionados à cena do Rick.
///
/// Todos os eventos estendem esta classe e são comparáveis por valor
/// utilizando o pacote [Equatable], o que facilita testes e atualizações de estado.
abstract class RickSceneEvent extends Equatable {
  const RickSceneEvent();

  @override
  List<Object?> get props => [];
}

/// Evento que dispara a fala padrão do Rick.
///
/// Este evento normalmente toca o áudio `requiredsound.mp3`,
/// e é usado em interações iniciais com o personagem.
class PlayRequiredSound extends RickSceneEvent {}

/// Evento que indica que Rick ficou preso em portais.
///
/// Ao ser processado, toca o áudio `lockedinportals.mp3` e
/// muda o estado para ativar os portais.
class PlayLockedInPortals extends RickSceneEvent {}

/// Evento que representa o momento em que o usuário ajudou o Pickle Rick.
///
/// Normalmente faz Rick agradecer e, em seguida, ativa um novo áudio
class HelpedPickleRick extends RickSceneEvent {}
