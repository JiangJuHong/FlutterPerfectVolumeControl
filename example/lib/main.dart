import 'package:flutter/material.dart';
import 'package:perfect_volume_control/perfect_volume_control.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  TextEditingController _textEditingController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextField(controller: _textEditingController),
                Container(height: 10),
                Center(
                  child: Wrap(
                    spacing: 10,
                    runSpacing: 10,
                    children: [
                      OutlinedButton(
                        child: Text("hideUI"),
                        onPressed: () async {
                          PerfectVolumeControl.hideUI = true;
                          _textEditingController.text = "hideUI finish";
                        },
                      ),
                      OutlinedButton(
                        child: Text("showUI"),
                        onPressed: () async {
                          PerfectVolumeControl.hideUI = false;
                          _textEditingController.text = "showUI finish";
                        },
                      ),
                      OutlinedButton(
                        child: Text("getVolume"),
                        onPressed: () async {
                          double volume = await PerfectVolumeControl.getVolume();
                          _textEditingController.text = "$volume";
                        },
                      ),
                      OutlinedButton(
                        child: Text("mute"),
                        onPressed: () async {
                          await PerfectVolumeControl.setVolume(0);
                          _textEditingController.text = "mute finish";
                        },
                      ),
                      OutlinedButton(
                        child: Text("setVolume to 0.3"),
                        onPressed: () async {
                          await PerfectVolumeControl.setVolume(0.3);
                          _textEditingController.text = "setVolume to 0.3 finish";
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
