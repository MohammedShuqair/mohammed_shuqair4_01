import 'dart:math';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';

import 'model/song.dart';

const Color backgroundColor = Color(0xffe8eefc);

const double p24 = 24;
const double p18 = 18;
const double p14 = 14;

const double s100 = 100;
const double s80 = 80;
const double s50 = 50;
const double s32 = 32;
const double s28 = 28;
const double s18 = 18;
const double s8 = 8;

const String image = "assets/images/mohammed.abu.shuqair.jpg";

class SongView extends StatefulWidget {
  const SongView({Key? key, required this.song}) : super(key: key);
  final Song song;
  @override
  State<SongView> createState() => _SongViewState();
}

class _SongViewState extends State<SongView> {
  late double min = 50;
  late double max = 150;
  late double slid;
  final AudioPlayer audioPlayer = AudioPlayer();

  bool isPlaying = false;
  Duration duration = Duration.zero;
  Duration position = Duration.zero;
  final String url =
      "http://commondatastorage.googleapis.com/codeskulptor-demos/DDR_assets/Kangaroo_MusiQue_-_The_Neverwritten_Role_Playing_Game.mp3";

  setAudio() async {
    await audioPlayer.play(AssetSource('songs/hamood.mp3'));

    // audioPlayer.setReleaseMode(ReleaseMode.loop);

    // await audioPlayer.play();
  }

  @override
  void initState() {
    // min = position.inSeconds.toDouble();
    slid = min;
    // max = duration.inSeconds.toDouble();
    audioPlayer.onPlayerStateChanged.listen((state) {
      setState(() {
        isPlaying = state == PlayerState.playing;
      });
      audioPlayer.onDurationChanged.listen((newDuration) {
        setState(() {
          duration = newDuration;
          // max = duration.inSeconds.toDouble();
        });
      });
      audioPlayer.onPositionChanged.listen((newPosition) {
        setState(() {
          position = newPosition;
          // min = position.inSeconds.toDouble();
          // slid = min;
        });
      });
    });
    super.initState();
  }

  double rotateAngle() {
    return 2 * pi * (slid - min) / ((max - min));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: CustomAppBar(
        children: [
          IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Shadow.icon(
                icon: Icons.arrow_back_ios,
              )),
          IconButton(
            icon: const Shadow.icon(
              icon: Icons.stop,
            ),
            onPressed: () {},
          )
        ],
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Shadow.image(
                rotate: rotateAngle(),
                radius: s100,
                imagePath: image,
              ),
              const SizedBox(
                height: s18,
              ),
              Text(
                widget.song.name,
                style: Theme.of(context)
                    .textTheme
                    .titleLarge
                    ?.copyWith(fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: s8,
              ),
              Text(
                widget.song.singer,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              const SizedBox(
                height: s28,
              ),
              TimeBar(
                  slid: position.inSeconds.toDouble(),
                  max: duration.inSeconds.toDouble()),
              Slider(
                  value: position.inSeconds.toDouble(),
                  label: slid.toStringAsFixed(0),
                  min: 0,
                  max: position.inSeconds.toDouble(),
                  // divisions: divisions,
                  onChanged: (value) async {
                    final position = Duration(seconds: value.toInt());
                    await audioPlayer.seek(position);
                    // setState(() {
                    //   slid = value;
                    // });
                  })
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.only(
          bottom: p24,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Shadow.icon(
              radius: s32,
              icon: Icons.fast_rewind_rounded,
            ),
            SizedBox(
              width: s18,
            ),
            IconButton(
              onPressed: () async {
                isPlaying
                    ? await audioPlayer.pause()
                    : await audioPlayer.play(AssetSource("songs/hamood.mp3"));
              },
              icon: Shadow.icon(
                radius: s32,
                shadow: false,
                icon: isPlaying ? Icons.pause : Icons.play_arrow,
                backgroundColor:
                    isPlaying ? Color(0xff72a3ff) : Color(0xffcbd4db),
                iconColor: Colors.white,
              ),
            ),
            SizedBox(
              width: s18,
            ),
            Shadow.icon(
              radius: s32,
              icon: Icons.fast_forward,
            ),
          ],
        ),
      ),
    );
  }
}

class TimeBar extends StatelessWidget {
  const TimeBar({
    super.key,
    required this.slid,
    required this.max,
  });

  final double slid;
  final double max;

  @override
  Widget build(BuildContext context) {
    TextStyle? caption = Theme.of(context)
        .textTheme
        .bodySmall
        ?.copyWith(color: Colors.grey[600]);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: p18),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            slid.toStringAsFixed(0),
            style: caption,
          ),
          Text(
            max.toStringAsFixed(0),
            style: caption,
          ),
        ],
      ),
    );
  }
}

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({
    super.key,
    required this.children,
    this.verticalPadding,
    this.contentHeight = s80,
  });
  final List<Widget> children;
  final double? verticalPadding;
  final double? contentHeight;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: p14, vertical: verticalPadding ?? 0),
          child: SizedBox(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: children,
            ),
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize =>
      Size.fromHeight((contentHeight ?? 0) + ((verticalPadding ?? 0) * 2));
}

class Shadow extends StatelessWidget {
  const Shadow.icon({
    super.key,
    required this.icon,
    this.iconColor = const Color(0xff9f9f9f),
    this.radius = s28,
    this.backgroundColor = const Color(0xffcbd4db),
    this.shadow = true,
    this.imagePath,
    this.rotate,
  }) : assert(
          imagePath == null,
        );
  const Shadow.image({
    super.key,
    this.icon,
    this.iconColor,
    this.radius = s28,
    this.backgroundColor = const Color(0xffe8eefc),
    this.shadow = true,
    this.imagePath,
    this.rotate,
  }) : assert(
          icon == null && iconColor == null,
        );
  final double? rotate;
  final IconData? icon;
  final String? imagePath;
  final Color? iconColor;
  final Color? backgroundColor;
  final double radius;
  final bool shadow;
  static const double shadowPosition = 10;
  static const double blurRadius = 15;
  static const double spreadRadius = 2;
  @override
  Widget build(BuildContext context) {
    return Transform.rotate(
      angle: rotate ?? 0,
      child: Container(
        width: radius * 2,
        height: radius * 2,
        decoration: BoxDecoration(
            color: backgroundColor,
            shape: BoxShape.circle,
            image: imagePath != null
                ? DecorationImage(
                    image: AssetImage(imagePath!), fit: BoxFit.cover)
                : null,
            boxShadow: shadow
                ? [
                    const BoxShadow(
                      color: Colors.white,
                      offset: Offset(-shadowPosition, -shadowPosition),
                      blurRadius: blurRadius,
                      spreadRadius: spreadRadius,
                    ),
                    const BoxShadow(
                      color: Colors.grey,
                      offset: Offset(shadowPosition, shadowPosition),
                      blurRadius: blurRadius,
                      spreadRadius: spreadRadius,
                    ),
                  ]
                : null),
        child: icon != null
            ? Icon(
                icon,
                color: iconColor,
              )
            : null,
      ),
    );
  }
}

// class ShadowWidget extends StatelessWidget {
//   const ShadowWidget({
//     super.key,
//     this.radius = s28,
//     this.backgroundColor = const Color(0xffcbd4db),
//     this.shadow = true,
//     required this.child,
//   });
//   final Color? backgroundColor;
//   final double radius;
//   final bool shadow;
//   static const double shadowPosition = 10;
//   static const double blurRadius = 15;
//   static const double spreadRadius = 5;
//   final Widget child;
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       width: radius * 2,
//       height: radius * 2,
//       decoration: BoxDecoration(
//           color: backgroundColor,
//           shape: BoxShape.circle,
//           image: AssetImage(),
//           boxShadow: shadow
//               ? [
//                   const BoxShadow(
//                     color: Colors.white,
//                     offset: Offset(-shadowPosition, -shadowPosition),
//                     blurRadius: blurRadius,
//                     spreadRadius: spreadRadius,
//                   ),
//                   const BoxShadow(
//                     color: Colors.grey,
//                     offset: Offset(shadowPosition, shadowPosition),
//                     blurRadius: blurRadius,
//                     spreadRadius: spreadRadius,
//                   ),
//                 ]
//               : null),
//       child: child,
//     );
//   }
// }
