import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vlc_player/flutter_vlc_player.dart';
import 'package:teleplay/screens/home/models/movie_model.dart';

/// Stateful widget to fetch and then display video content.
class VideoPlayerPage extends StatefulWidget {
  const VideoPlayerPage({
    Key? key,
    required this.movieModel,
    required this.magnetLink,
  }) : super(key: key);
  final MovieModel movieModel;
  final String magnetLink;

  @override
  _VideoPlayerPageState createState() => _VideoPlayerPageState();
}

class _VideoPlayerPageState extends State<VideoPlayerPage> {
  late VlcPlayerController _videoPlayerController;

  @override
  void initState() {
    print(
        'http://159.65.242.239/stream?magnet=${widget.magnetLink}&filePath=${widget.movieModel.path}');

    _videoPlayerController = VlcPlayerController.network(
        'http://159.65.242.239/stream?magnet=${widget.magnetLink}&filePath=${widget.movieModel.path}',
        hwAcc: HwAcc.full,
        autoPlay: true,
        options: VlcPlayerOptions());

    super.initState();
  }

  @override
  void dispose() async {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: Center(
          child: Column(
            children: [
              Expanded(
                child: VlcPlayer(
                  virtualDisplay: true,
                  controller: _videoPlayerController,
                  aspectRatio: 16 / 9,
                  placeholder:
                      const Center(child: CupertinoActivityIndicator()),
                ),
              ),
              Expanded(
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.movieModel.name,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20),
                      ),
                      Text(
                        widget.movieModel.size,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 30),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
