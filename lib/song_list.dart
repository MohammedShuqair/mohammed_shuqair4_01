import 'package:assignment4_01/model/song.dart';
import 'package:assignment4_01/song_view.dart';
import 'package:flutter/material.dart';

class SongList extends StatefulWidget {
  const SongList({Key? key, required this.songs}) : super(key: key);
  final List<Song> songs;

  @override
  State<SongList> createState() => _SongListState();
}

class _SongListState extends State<SongList> {
  static const double radius = s80;
  static const double contentHeight = radius * 2;
  static const double verticalPadding = s100;

  late int itemCount;
  late String? imagePath;
  late List<bool> isSelected;
  late Song? song;
  @override
  void initState() {
    song = widget.songs.isEmpty ? null : widget.songs.first;

    imagePath = song?.imagePath;
    itemCount = widget.songs.length;
    isSelected = List.generate(itemCount, (index) => false);
    isSelected[0] = true;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            CustomAppBar(
              verticalPadding: verticalPadding,
              contentHeight: contentHeight,
              children: [
                IconButton(
                    onPressed: () {
                      song != null
                          ? Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (_) => SongView(song: song!)))
                          : null;
                    },
                    icon: const Shadow.icon(
                      icon: Icons.file_open,
                    )),
                song != null
                    ? Shadow.image(
                        // rotate: rotateAngle(),
                        radius: radius,
                        imagePath: imagePath!,
                      )
                    : SizedBox(),
                IconButton(
                  icon: const Shadow.icon(
                    icon: Icons.settings_ethernet,
                  ),
                  onPressed: () {},
                )
              ],
            ),
            ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: itemCount,
                padding: const EdgeInsets.symmetric(horizontal: 8),
                separatorBuilder: (_, __) => const SizedBox(
                      height: s8,
                    ),
                itemBuilder: (_, index) => SongCard(
                      title: widget.songs[index].name,
                      subtitle: widget.songs[index].singer,
                      index: index,
                      selected: isSelected[index],
                      onTap: (cIndex) {
                        setState(() {
                          isSelected.fillRange(0, cIndex, false);
                          isSelected.fillRange(cIndex + 1, itemCount, false);
                          isSelected[cIndex] = !isSelected[cIndex];
                          print(isSelected);
                        });
                      },
                    )),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.only(bottom: p24, top: p24),
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
                // isPlaying
                //     ? await audioPlayer.pause()
                //     : await audioPlayer.resume();
              },
              icon: Shadow.icon(
                radius: s32,
                shadow: false,
                icon: Icons.pause,
                backgroundColor: Color(0xff72a3ff),
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

class SongCard extends StatelessWidget {
  const SongCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.onTap,
    required this.index,
    required this.selected,
  });

  final String title;
  final String subtitle;
  final Function(int) onTap;
  final int index;
  final bool selected;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        onTap(index);
      },
      visualDensity: const VisualDensity(vertical: 0),
      contentPadding: const EdgeInsetsDirectional.only(start: s8),
      selectedColor: const Color(0xff65748b),
      selected: selected,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      selectedTileColor: const Color(0xffccdbf2),
      title: Text(title),
      subtitle: Text(subtitle),
      trailing: IconButton(
        onPressed: () {
          onTap(index);
        },
        icon: Shadow.icon(
          icon: selected ? Icons.stop : Icons.play_arrow,
          shadow: !selected,
          backgroundColor: selected ? Color(0xff8aa9f9) : Color(0xffcbd4db),
        ),
      ),
    );
  }
}
