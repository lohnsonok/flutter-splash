import 'dart:io';

import 'package:audioplayers/audio_cache.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

//import 'package:audiofileplayer/audiofileplayer.dart';

import 'package:audioplayers/audioplayers.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: SplashScreen(),
    );
  }
}

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 8), () {
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => MyHomePage(),
          ));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FlareActor(
        "assets/splash.flr",
        alignment: Alignment.center,
        fit: BoxFit.contain,
        animation: "intro",
        color: Color(0xff181818),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  AudioCache audioCache = AudioCache();
  AudioPlayer advancedPlayer = AudioPlayer();
  String localFilePath;

  //Audio audio = Audio.load(
  //   'assets/audios/Jean-Paul Césari - Nicky Larson Générique TV French opening.mp3');

/*   _playSound() {
    return AssetsAudioPlayer.newPlayer().open(
        Audio(
            "assets/audios/Jean-Paul Césari - Nicky Larson Générique TV French opening.mp3"),
        autoStart: true,
        showNotification: true,
        playInBackground: PlayInBackground.enabled);
  } */

  @override
  void initState() {
    super.initState();

    if (kIsWeb) {
      // Calls to Platform.isIOS fails on web
      return;
    }
    if (Platform.isIOS) {
      if (audioCache.fixedPlayer != null) {
        audioCache.fixedPlayer.startHeadlessService();
      }
      advancedPlayer.startHeadlessService();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home"),
        backgroundColor: Color(0xff181818),
      ),
      body: Center(
        child: Text("Hello World"),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          audioCache.play(
              'Jean-Paul Césari - Nicky Larson Générique TV French opening.mp3');
        },
        tooltip: 'Play sound',
        child: Icon(Icons.play_arrow),
      ),
    );
  }
}
