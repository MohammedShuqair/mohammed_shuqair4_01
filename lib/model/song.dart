class Song {
  final String name;
  final String singer;
  final String song;
  final String imagePath;

  Song({
    required this.name,
    required this.singer,
    required this.song,
    required this.imagePath,
  });
  static List<Song> songs = [
    Song(
        name: "hamood",
        singer: "little hamood",
        song: 'songs/hamood.mp3',
        imagePath: 'assets/images/mohammed.abu.shuqair.jpg'),
    Song(
        name: "hamood",
        singer: "little hamood",
        song: 'songs/hamood.mp3',
        imagePath: 'assets/images/mohammed.abu.shuqair.jpg'),
  ];
}
