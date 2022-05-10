import 'dart:developer';

import 'package:audioplayers/audioplayers.dart';
import 'package:get/get.dart';

class AudioPlayerController extends GetxController {
  List voiceLinks = [];
  late final AudioPlayer _audioPlayer;
  bool _isPlaying = false,
      _isPaused = false,
      _isStopped = false,
      _isCompelete = false,
      _isloading = false;

  bool get isPlaying => _isPlaying;

  bool get isLoading => _isloading;

  bool get isPaused => _isPaused;

  bool get isStopped => _isStopped;

  bool get isCompelete => _isCompelete;

  Duration? currentPosition, length;

  AudioPlayer get audioPlayed => _audioPlayer;

  void _init() {
    _audioPlayer = AudioPlayer();
    _audioPlayer.onPlayerStateChanged.listen((event) {
      if (event == PlayerState.PLAYING) {
        _isPlaying = true;
        _isPaused = false;
        _isStopped = false;
        update();
      } else if (event == PlayerState.PAUSED) {
        _isPaused = true;
        _isStopped = false;
        _isPlaying = false;
        update();
      } else if (event == PlayerState.STOPPED) {
        _isStopped = true;
        _isPlaying = false;
        _isPaused = false;
        update();
      } else {
        _isPlaying = false;
        _isPaused = false;
        _isStopped = false;
        _isCompelete = true;
        update();
        log(event.name);
      }
      update();
    });
    _audioPlayer.onPlayerCompletion.listen((event) {
      _isCompelete = true;
      _isPlaying = false;
      _isPaused = false;
      _isStopped = false;
      update();
    });
    _audioPlayer.onDurationChanged.listen((Duration d) {
      length = d;
      update();
    });

    _audioPlayer.onAudioPositionChanged.listen((Duration p) {
      {
        currentPosition = p;
        update();
      }
    });
    _isloading = false;
  }

  void _dispose() {
    _audioPlayer.dispose();
  }

  Future play({
    Duration? position,
    required String url,
    required int index,
  }) async {
    await _audioPlayer.play(
      url,
      position: position,
    );
    update();
  }

  Future _pause() async {
    await _audioPlayer.pause();
    update();
  }

  Future _stop() async {
    await _audioPlayer.stop();
    update();
  }

  Future _resume() async {
    await _audioPlayer.resume();
    update();
  }

  void changeToSecond({required int seconds}) {
    Duration duration = Duration(seconds: seconds);
    audioPlayed.seek(duration);
    update();
  }

//
  void onPlayPauseButtonClick({required String url, required int index}) {
    _isloading = true;
    if (isPlaying) {
      _pause();
    } else if (isPaused) {
      _resume();
    } else {
      _isloading = true;

      play(url: url, index: index);
    }
    _isloading = false;

    update();
  }

  @override
  void onInit() {
    _init();
    super.onInit();
  }

  @override
  void dispose() {
    _dispose();
    super.dispose();
  }

  @override
  void onClose() {
    _dispose();
    super.onClose();
  }
}
