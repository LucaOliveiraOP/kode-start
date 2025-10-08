import 'dart:async';
import 'dart:collection';
import 'package:audioplayers/audioplayers.dart';

class RickAudioController {
  final AudioPlayer _player = AudioPlayer();
  final Queue<String> _audioQueue = Queue<String>();
  bool _isPlaying = false;

  /// Adiciona o áudio à fila e tenta iniciar a reprodução se não estiver tocando.
  Future<void> play(String fileName) async {
    _audioQueue.add(fileName);
    _tryPlayNext();
  }

  /// Tenta tocar o próximo áudio na fila, se não estiver já tocando.
  void _tryPlayNext() async {
    if (_isPlaying || _audioQueue.isEmpty) return;

    _isPlaying = true;
    final currentFile = _audioQueue.removeFirst();

    try {
      await _player.stop();
      await _player.play(AssetSource('audio/$currentFile'));

      // Aguarda o término da reprodução
      final completer = Completer<void>();
      late StreamSubscription<void> subscription;
      subscription = _player.onPlayerComplete.listen((_) {
        if (!completer.isCompleted) {
          completer.complete();
          subscription.cancel();
        }
      });

      await completer.future;
    } catch (e) {
      print("Erro ao tocar áudio: $e");
    } finally {
      _isPlaying = false;
      _tryPlayNext(); // Toca o próximo da fila, se houver
    }
  }

  /// Para a reprodução atual e limpa a fila.
  Future<void> stop() async {
    await _player.stop();
    _audioQueue.clear();
    _isPlaying = false;
  }
}
