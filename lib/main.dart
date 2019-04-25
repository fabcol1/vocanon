import 'package:flutter/material.dart';
import 'audio_recorder_console.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Vocanon',
      theme: ThemeData(
        primaryColor: Colors.white,
      ),
      home: MainWidget(),
    );
  }
}

class MainWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(35.0),
          child: AppBar(title: Text('Vocanon')),
        ),
        body: Container(),
        bottomNavigationBar: BottomAppBar(
          child: new AudioRecorderConsole(),
        ));
  }
}
