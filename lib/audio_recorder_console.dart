import 'package:flutter/material.dart';
import 'stopwatch_view.dart';

class AudioRecorderConsoleState extends State<AudioRecorderConsole> {
  bool _isRecording = false;

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

  Widget startRecordingButton(BuildContext context) {
    return new FloatingActionButton(
        backgroundColor: Colors.green,
        mini: true,
        child: new Icon(Icons.mic, size: 26.0),
        onPressed: () => setState(() {
              _isRecording = true;
            }));
  }

  Widget stopRecordingButton(BuildContext context) {
    return new Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          new TimeComponent(),
          new FloatingActionButton(
              backgroundColor: Colors.red,
              mini: true,
              child: new Icon(Icons.stop, size: 26.0),
              onPressed: () => setState(() {
                    _isRecording = false;
                  }))
        ]);
  }
}

class AudioRecorderConsole extends StatefulWidget {
  @override
  AudioRecorderConsoleState createState() => new AudioRecorderConsoleState();
}
