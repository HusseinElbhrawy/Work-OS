import 'dart:developer';

import 'package:audioplayers/audioplayers.dart';

class SoundPlayed2 {
  late final AudioPlayer _audioPlayer;
  bool _isPlaying = false,
      _isPaused = false,
      _isStopped = false,
      _isCompelete = false;

  bool get isPlaying => _isPlaying;

  bool get isPaused => _isPaused;

  bool get isStopped => _isStopped;

  bool get isCompelete => _isCompelete;

  Duration? currentPosition, length;

  // Duration get currentPosition => _currentPosition!;

  // Duration get length => _length!;

  AudioPlayer get audioPlayed => _audioPlayer;

  void init() {
    _audioPlayer = AudioPlayer();

    _audioPlayer.onPlayerStateChanged.listen((event) {
      if (event == PlayerState.PLAYING) {
        _isPlaying = true;
        _isPaused = false;
        _isStopped = false;
      } else if (event == PlayerState.PAUSED) {
        _isPaused = true;
        _isStopped = false;
        _isPlaying = false;
      } else if (event == PlayerState.STOPPED) {
        _isStopped = true;
        _isPlaying = false;
        _isPaused = false;
      } else {
        _isPlaying = false;
        _isPaused = false;
        _isStopped = false;
        _isCompelete = true;

        log(event.name);
      }
    });
    _audioPlayer.onPlayerCompletion.listen((event) {
      _isCompelete = true;
      _isPlaying = false;
      _isPaused = false;
      _isStopped = false;
    });
    _audioPlayer.onDurationChanged.listen((Duration d) {
      length = d;
    });

    _audioPlayer.onAudioPositionChanged.listen((Duration p) {
      {
        currentPosition = p;
      }
    });
  }

  void dispose() {
    _audioPlayer.dispose();
  }

  Future play({Duration? position}) async {
    await _audioPlayer.play(
      '/data/user/0/com.example.work_os/cache/audio_example.aac',
      position: position,
    );
  }

  Future pause() async {
    await _audioPlayer.pause();
  }

  Future stop() async {
    await _audioPlayer.stop();
  }

  Future resume() async {
    await _audioPlayer.resume();
  }

  void changeToSecond({required int seconds}) {
    Duration duration = Duration(seconds: seconds);
    audioPlayed.seek(duration);
  }
}
