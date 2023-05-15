import 'package:flutter/material.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:permission_handler/permission_handler.dart';

final pathToSaveAudio = 'audio_example.acc';

class SoundRecorder {
  FlutterSoundRecorder? _audioRecorder;
  bool _isRecorderInitialised = false;

  bool get isRecording => _audioRecorder!.isRecording;

  Future init() async {
    _audioRecorder = FlutterSoundRecorder();

    final status = await Permission.microphone.request();
    if (status != PermissionStatus.granted) {
      throw RecordingPermissionException('Microphone permission denied.');
    }

    await _audioRecorder!.openRecorder();
    _isRecorderInitialised = true;
  }

  void dispose() {
    _audioRecorder!.closeRecorder();
    _audioRecorder = null;
    _isRecorderInitialised = false;
  }

  Future _record() async {
    await _audioRecorder!.startRecorder(toFile: pathToSaveAudio);
  }

  Future _stop() async {
    await _audioRecorder!.stopRecorder();
  }

  Future toggleRecording() async {
    if (_audioRecorder!.isStopped) {
      await _record();
    } else {
      await _stop();
    }
  }
}
