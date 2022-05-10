import 'package:flutter/material.dart';
import 'package:work_os/modules/sound_player.dart';

import 'package:work_os/views/test/audio_waveform_widget.dart';

class LastRecordingBubble extends StatelessWidget {
  const LastRecordingBubble({
    Key? key,
    required this.time,
    required this.path,
    required this.onTap,
  }) : super(key: key);
  final int time;
  final String path;
  final Function onTap;

  String _formatNumber(int number) {
    String numberStr = number.toString();
    if (number < 10) {
      numberStr = '0' + numberStr;
    }

    return numberStr;
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(16),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          LRPlayPauseButton(
            path: path,
            onTap: () => onTap(),
          ),
          AudioWaveformWidget(
            duration: time.clamp(0, 25),
            strokeWidth: 4,
            waveColor: Theme.of(context).colorScheme.secondary,
            child: SizedBox(
              height: 60,
              width: time.clamp(0, 25) * 8.0,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8),
            child: TextButton(
              onPressed: () {},
              child: Text(
                '${_formatNumber(time ~/ 60)}:${_formatNumber(time % 60)}',
                style: Theme.of(context).textTheme.overline?.copyWith(
                      color: Theme.of(context)
                          .textTheme
                          .overline
                          ?.color
                          ?.withOpacity(1),
                    ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class LRPlayPauseButton extends StatefulWidget {
  const LRPlayPauseButton({
    Key? key,
    required this.path,
    required this.onTap,
  }) : super(key: key);
  final String path;
  final Function onTap;
  @override
  _LRPlayPauseButtonState createState() => _LRPlayPauseButtonState();
}

class _LRPlayPauseButtonState extends State<LRPlayPauseButton>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> animation;
  bool playing = false;
  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    );
    animation = Tween(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: controller,
        curve: Curves.easeInOut,
      ),
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final audioPlayed = SoundPlayed();
    setState(() {});
    return IconButton(
      onPressed: () => widget.onTap(),
      icon: AnimatedIcon(
        icon: audioPlayed.isPlaying
            ? AnimatedIcons.play_pause
            : AnimatedIcons.pause_play,
        progress: animation,
      ),
    );
  }
}
