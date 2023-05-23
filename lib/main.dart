import 'package:assignment4_01/model/song.dart';
import 'package:assignment4_01/profile.dart';
import 'package:assignment4_01/song_list.dart';
import 'package:assignment4_01/song_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(
          scaffoldBackgroundColor: backgroundColor,
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: Profile()
        // home: SongList(
        //   songs: Song.songs,
        // ),
        );
  }
}
