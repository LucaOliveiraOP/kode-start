import 'dart:developer';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'rick_scene_event.dart';
import 'rick_scene_state.dart';
import 'package:save_rick_kode_start/controllers/rick_audio_controller.dart';

/// [RickSceneBloc] é responsável por controlar a lógica de estado relacionada
/// às interações sonoras e visuais do Rick.
///
/// Ele escuta eventos como:
/// - [PlayRequiredSound]: Rick fala algo obrigatório, ligar o som.
/// - [PlayLockedInPortals]: Rick está preso nos portais.
/// - [HelpedPickleRick]: Rick agradece por tê-lo ajudado.
///
/// Cada evento pode:
/// - Emitir estados que representam uma fala do Rick.
/// - Tocar um áudio específico.
/// - Alterar o estado visual (ex: mostrar animação de portais).
class RickSceneBloc extends Bloc<RickSceneEvent, RickSceneState> {
  /// Controlador responsável por tocar os áudios do Rick.
  final RickAudioController _audioController = RickAudioController();
  bool _hasSpokenAboutEvilMorty = false;
  bool _evilMortyWasSpoken = false;

  /// Construtor do BLoC que mapeia eventos para manipuladores.
  RickSceneBloc() : super(const RickSceneInitial()) {
    on<PlayRequiredSound>(_onPlayRequiredSound);
    on<PlayLockedInPortals>(_onPlayLockedInPortals);
    on<HelpedPickleRick>(_onHelpedPickleRick);
    on<RickSpeakAboutEvilMorty>(_onRickSpeakAboutEvilMorty);
    on<SpeakEvilMortyRunningAway>(_onSpeakEvilMortyRunningAway);
  }

  /// Manipula o evento [PlayRequiredSound], emitindo um estado com o áudio
  /// 'requiredsound.mp3' e tocando esse áudio.
  Future<void> _onPlayRequiredSound(
    PlayRequiredSound event,
    Emitter<RickSceneState> emit,
  ) async {
    emit(const RickSpeaking('requiredsound.mp3'));
    await _audioController.play('requiredsound.mp3');
  }

  /// Manipula o evento [PlayLockedInPortals], emitindo dois estados:
  /// - Primeiro, toca o áudio 'lockedinportals.mp3'.
  /// - Depois, emite o estado [LockedInPortals] que pode ativando animação visual.
  Future<void> _onPlayLockedInPortals(
    PlayLockedInPortals event,
    Emitter<RickSceneState> emit,
  ) async {
    log('PlayLockedInPortals event recebido');
    emit(const RickSpeaking('lockedinportals.mp3'));
    await _audioController.play('lockedinportals.mp3');
    emit(const LockedInPortals());
  }

  /// Manipula o evento [HelpedPickleRick]:
  /// - Primeiro, Rick agradece com o áudio 'thanksforhelp.mp3'.
  /// - Em seguida, toca 'searchportalopen.mp3' como transição.
  /// - Por fim, retorna ao estado inicial.
  Future<void> _onHelpedPickleRick(
    HelpedPickleRick event,
    Emitter<RickSceneState> emit,
  ) async {
    log('Emitindo thanksforhelp.mp3');
    emit(const RickSpeaking('thanksforhelp.mp3'));
    await _audioController.play('thanksforhelp.mp3');

    log('Emitindo searchportalopen.mp3');
    emit(const RickSpeaking('searchportalopen.mp3'));
    await _audioController.play('searchportalopen.mp3');

    emit(const RickSceneInitial());
  }

  Future<void> _onRickSpeakAboutEvilMorty(
    RickSpeakAboutEvilMorty event,
    Emitter<RickSceneState> emit,
  ) async {
    if (_hasSpokenAboutEvilMorty) return;

    _hasSpokenAboutEvilMorty = true;

    log('Emitindo evilmortymightbehere.mp3');
    emit(const RickSpeaking('evilmortymightbehere.mp3'));
    await _audioController.play('evilmortymightbehere.mp3');
    emit(const RickSceneInitial());
  }

  Future<void> _onSpeakEvilMortyRunningAway(
    SpeakEvilMortyRunningAway event,
    Emitter<RickSceneState> emit,
  ) async {
    if (_evilMortyWasSpoken) return;

    _evilMortyWasSpoken = true;

    log('Emitindo evilmortymightbehere.mp3');
    emit(const RickSpeaking('mortyrunningaway.mp3'));
    await _audioController.play('mortyrunningaway.mp3');
    emit(EvilMortySaidIsGoingAway());
    log('Emitindo soundgoingawaymorty.mp3');
    emit(const RickSpeaking('soundgoingawaymorty.mp3'));
    await _audioController.play('soundgoingawaymorty.mp3');
  }
}
