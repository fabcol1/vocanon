import 'dart:io';
import 'package:flutter/material.dart';
import 'continuos_fade_in_out.dart';
import 'stopwatch_view.dart';

import 'package:audio_recorder2/audio_recorder2.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:audioplayer/audioplayer.dart';

class AudioRecorderConsoleState extends State<AudioRecorderConsole> {
  Recording _recording;
  bool _isRecording = false;
  ContinuosFadeInFadeOut continuosFadeInFadeOut;
  String tempFilename = "TempRecording";
  File defaultAudioFile;

  @override
  Widget build(BuildContext context) {
    return audioRecorderConsole(context);
  }

  Widget audioRecorderConsole(BuildContext context) {
    return new Container(
        height: 60.0,
        child: new Center(
            child: _isRecording
                ? stopRecordingButton(context)
                : startRecordingButton(context)));
  }

  startRecording() async {
    try {
      Directory docDir = await getApplicationDocumentsDirectory();
      String newFilePath = p.join(docDir.path, this.tempFilename);
      File tempAudioFile = File(newFilePath + '.m4a');
      if (await tempAudioFile.exists()) {
        await tempAudioFile.delete();
      }
      if (await AudioRecorder2.hasPermissions) {
        await AudioRecorder2.start(
            path: newFilePath, audioOutputFormat: AudioOutputFormat.AAC);
      } else {
        Scaffold.of(context).showSnackBar(new SnackBar(
            content: new Text("Error! Audio recorder lacks permissions.")));
      }
      bool isRecording = await AudioRecorder2.isRecording;
      setState(() {
        _recording = new Recording(duration: new Duration(), path: newFilePath);
        _isRecording = isRecording;
        defaultAudioFile = tempAudioFile;
      });
    } catch (e) {
      print(e);
    }
  }

  Widget startRecordingButton(BuildContext context) {
    return new FloatingActionButton(
        backgroundColor: Colors.green,
        mini: true,
        child: new Icon(Icons.mic, size: 26.0),
        onPressed: () => startRecording());
  }

  stopRecording() async {
    // Await return of Recording object
    var recording = await AudioRecorder2.stop();
    bool isRecording = await AudioRecorder2.isRecording;

    Directory docDir = await getApplicationDocumentsDirectory();

    AudioPlayer audioPlayer = new AudioPlayer();
    await audioPlayer.play(p.join(docDir.path, this.tempFilename + '.m4a'));

    print(p.join(docDir.path, this.tempFilename + '.m4a'));

    setState(() {
      _isRecording = isRecording;
      defaultAudioFile = File(p.join(docDir.path, this.tempFilename + '.m4a'));
    });
  }

  Widget stopRecordingButton(BuildContext context) {
    continuosFadeInFadeOut = new ContinuosFadeInFadeOut();
    return new Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          continuosFadeInFadeOut,
          new TimeComponent(),
          new FloatingActionButton(
              backgroundColor: Colors.red,
              mini: true,
              child: new Icon(Icons.stop, size: 26.0),
              onPressed: () => stopRecording())
        ]);
  }
}

class AudioRecorderConsole extends StatefulWidget {
  @override
  AudioRecorderConsoleState createState() => new AudioRecorderConsoleState();
}
