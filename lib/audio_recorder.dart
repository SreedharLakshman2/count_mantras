import 'package:count_mantras/api/sound_recorder.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sound/flutter_sound.dart';

class AudioRecorder extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return AudioRecorderState();
  }
}

class AudioRecorderState extends State<AudioRecorder> {
  final recorder = SoundRecorder();

  @override
  void initState() {
    // TODO: implement initState
    recorder.init();
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    recorder.dispose();

    super.dispose();
  }

  Widget build(context) {
    var isRecording = recorder.isRecording;
    final icon = isRecording ? Icons.stop : Icons.mic;
    final text = isRecording ? 'Stop' : 'Start';
    return ElevatedButton.icon(
      onPressed: () async {
        setState(() async {
          isRecording = await recorder.toggleRecording();
        });
      },
      icon: Icon(
        icon,
        size: 30,
        color: Colors.white,
      ), //icon data for elevated button
      label: Text(
        text,
        style: TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.bold,
        ),
        maxLines: 1,
      ), //label text
    );
  }
}
