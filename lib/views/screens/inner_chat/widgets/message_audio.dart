import 'dart:developer';

import 'package:audioplayers/audioplayers.dart';
import 'package:chat_bubbles/bubbles/bubble_normal_audio.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:work_os/controller/audio_palyer.dart';
import 'package:work_os/controller/style_controller.dart';

class MessageAudioWidget extends StatefulWidget {
  const MessageAudioWidget({
    Key? key,
    required this.voiceUrl,
    required this.isTheSameUser,
    required this.timestamp,
    required this.index,
    required this.id,
  }) : super(key: key);
  final String voiceUrl;
  final bool isTheSameUser;
  final Timestamp timestamp;
  final int index;
  final String id;

  @override
  State<MessageAudioWidget> createState() => _MessageAudioWidgetState();
}

class _MessageAudioWidgetState extends State<MessageAudioWidget> {
  late final AudioPlayer _audioPlayer;
  Duration? currentPosition, length;

  bool isPlaying = false,
      isPaused = false,
      isStopped = false,
      isCompelete = false,
      isloading = false;
  @override
  void initState() {
    _audioPlayer = AudioPlayer();
    _audioPlayer.onPlayerStateChanged.listen((event) {
      if (event == PlayerState.PLAYING) {
        isPlaying = true;
        isPaused = false;
        isStopped = false;
      } else if (event == PlayerState.PAUSED) {
        isPaused = true;
        isStopped = false;
        isPlaying = false;
      } else if (event == PlayerState.STOPPED) {
        isStopped = true;
        isPlaying = false;
        isPaused = false;
      } else {
        isPlaying = false;
        isPaused = false;
        isStopped = false;
        isCompelete = true;

        log(event.name);
      }
      setState(() {});
    });
    _audioPlayer.onPlayerCompletion.listen((event) {
      isCompelete = true;
      isPlaying = false;
      isPaused = false;
      isStopped = false;
      setState(() {});
    });
    _audioPlayer.onDurationChanged.listen((Duration d) {
      length = d;
    });

    _audioPlayer.onAudioPositionChanged.listen((Duration p) {
      {
        currentPosition = p;
        setState(() {});
      }
    });
    isloading = false;
    super.initState();
  }

  @override
  void dispose() {
    _audioPlayer.dispose();

    super.dispose();
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
    setState(() {});
  }

  Future _pause() async {
    await _audioPlayer.pause();
    setState(() {});
  }

  Future _stop() async {
    await _audioPlayer.stop();
    setState(() {});
  }

  Future _resume() async {
    await _audioPlayer.resume();
    setState(() {});
  }

  void changeToSecond({required int seconds}) {
    Duration duration = Duration(seconds: seconds);
    _audioPlayer.seek(duration);
    setState(() {});
  }

  void onPlayPauseButtonClick({required String url, required int index}) {
    isloading = true;
    if (isPlaying) {
      _pause();
    } else if (isPaused) {
      _resume();
    } else {
      isloading = true;

      play(url: url, index: index);
    }
    isloading = false;

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    StyleController styleController = Get.find();
    return GetBuilder(
      init: AudioPlayerController(),
      builder: (AudioPlayerController controller) {
        return BubbleNormalAudio(
          key: Key(widget.id),
          color: widget.isTheSameUser ? Colors.red : Colors.blue,
          isLoading: false,
          isPlaying: isPlaying,
          duration: length != null ? length!.inSeconds.toDouble() : 0.0,
          position: currentPosition != null
              ? currentPosition!.inSeconds.toDouble()
              : 0.0,
          isPause: isPaused,
          onSeekChanged: (newValue) {
            changeToSecond(seconds: newValue.toInt());
          },
          onPlayPauseButtonClick: () {
            onPlayPauseButtonClick(
              index: widget.index,
              url: widget.voiceUrl,
            );
          },
          // sent: true,
          isSender: !widget.isTheSameUser,
          bubbleRadius: 5,
        );
      },
    );
  }
}
