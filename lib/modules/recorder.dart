import 'package:flutter_sound/flutter_sound.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:uuid/uuid.dart';

class SoundRecorder {
  FlutterSoundRecorder? _audioRecorder;
  bool _isRecorderInitialised = false;

  bool get isRecordering => _audioRecorder!.isRecording;

  Future _init() async {
    _audioRecorder = FlutterSoundRecorder();
    final status = await Permission.microphone.request();
    if (status != PermissionStatus.granted) {
      throw RecordingPermissionException('Microphone permission is denied');
    }
    await _audioRecorder!.openRecorder();
    _isRecorderInitialised = true;
  }

  void _dispose() {
    if (!_isRecorderInitialised) return;
    _audioRecorder!.closeRecorder();
    _audioRecorder = null;
    _isRecorderInitialised = false;
  }

  Future record() async {
    if (!_isRecorderInitialised) return;

    await _audioRecorder!.startRecorder(toFile: const Uuid().v4());
  }
}
