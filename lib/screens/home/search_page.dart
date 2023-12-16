import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'package:teleplay/components/search_results_movie_tile.dart';
import 'package:teleplay/screens/home/controller/movie_controller.dart';
import 'package:teleplay/screens/home/models/movie_model.dart';
import 'package:teleplay/screens/home/models/search_movie_model.dart';
import 'package:teleplay/screens/video_player.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  TextEditingController _searchController = TextEditingController();
  TextEditingController _magnetLinkController = TextEditingController();
  final SpeechToText _speechToText = SpeechToText();
  bool _speechEnabled = false;
  String _lastWords = '';
  MovieController _movieController = MovieController();
  List<MovieModel>? mediaResults;
  List<SearchMovieDataModel>? searchResults;
  bool isSearching = false;

  void _initSpeech() async {
    try {
      _speechEnabled = await _speechToText.initialize();
    } catch (e) {
      print(e.toString());
    }

    setState(() {});
  }

  void _startListening() async {
    try {
      await _speechToText.listen(onResult: _onSpeechResult);
      setState(() {});
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Text to speech not available"),
        ),
      );
    }
  }

  void _stopListening() async {
    await _speechToText.stop();
    setState(() {});
  }

  void _onSpeechResult(SpeechRecognitionResult result) {
    setState(() {
      print(result.recognizedWords.toString());
      _searchController.text = result.recognizedWords.toString();
    });
  }

  @override
  void initState() {
    _initSpeech();
    super.initState();
  }

  void pickMagnetfile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['torrent'],
    );

    if (result != null) {
      PlatformFile file = result.files.first;
      print(file.name);
      searchMovies(file.name);
    }
  }

  void fetchMedia() {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: Colors.blue[400],
        title: const Text(
          "Add File",
          style: TextStyle(color: Colors.white),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              "Select the file you want to upload",
              style: TextStyle(color: Colors.white),
            ),
            const SizedBox(
              height: 10,
            ),
            TextField(
              controller: _magnetLinkController,
              decoration: const InputDecoration(
                hoverColor: Colors.white,
                enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                    borderRadius: BorderRadius.all(Radius.circular(10))),
                border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                    borderRadius: BorderRadius.all(Radius.circular(10))),
                hintText: "Paste link here",
                hintStyle: TextStyle(color: Colors.white),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              width: MediaQuery.of(context).size.width * 0.8,
              height: 100,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Center(
                child: TextButton(
                  onPressed: () {
                    pickMagnetfile();
                  },
                  child: const Text(
                    "Select magnet File",
                    style: TextStyle(color: Colors.blue),
                  ),
                ),
              ),
            )
          ],
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.of(ctx).pop();
            },
            child: const Text(
              "Cancel",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
          ),
          TextButton(
            onPressed: getMediaData,
            child: const Text(
              "Open",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
          ),
        ],
      ),
    );
  }

  void getMediaData() async {
    setState(() {
      isSearching = true;
    });
    mediaResults =
        await _movieController.fetchMediaData(_magnetLinkController.text);
    setState(() {
      isSearching = false;
    });
    Navigator.of(context).pop();
    Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => VideoPlayerPage(
            magnetLink: _magnetLinkController.text,
            movieModel: MovieModel(
                name: mediaResults![0].name,
                path: mediaResults![0].path,
                size: mediaResults![0].size))));
    // _magnetLinkController.clear();
  }

  void searchMovies(String query) async {
    setState(() {
      isSearching = true;
    });

    searchResults = await _movieController.searchMovies(query);
    setState(() {
      isSearching = false;
    });
    print(searchResults);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: 80,
          title: Container(
            margin: const EdgeInsets.only(top: 2),
            child: SearchBar(
              onSubmitted: (value) {
                searchMovies(value);
              },
              controller: _searchController,
              textStyle: MaterialStateProperty.resolveWith<TextStyle?>(
                (states) => const TextStyle(color: Colors.white),
              ),
              trailing: [
                IconButton(
                    onPressed: _speechToText.isNotListening
                        ? _startListening
                        : _stopListening,
                    icon: Icon(
                      _speechToText.isNotListening ? Icons.mic : Icons.mic_off,
                      color: Colors.white,
                    )),
              ],
              shape: MaterialStateProperty.resolveWith<OutlinedBorder?>(
                (states) => RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
              leading: const Icon(
                Icons.search,
                size: 30,
                color: Colors.white,
              ),
              hintStyle: MaterialStateProperty.resolveWith<TextStyle?>(
                (states) => const TextStyle(color: Colors.white),
              ),
              backgroundColor: MaterialStateProperty.all<Color?>(Colors.blue),
              elevation: MaterialStateProperty.all<double?>(0),
              hintText: "Search in Torrents",
            ),
          ),
        ),
        body: Center(
          child: isSearching
              ? const CupertinoActivityIndicator()
              : Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListView.builder(
                      itemCount: searchResults?.length ?? 0,
                      itemBuilder: (context, index) {
                        return SearchResultsMovieTile(
                            searchMovieDataModel: searchResults![index]);
                      }),
                ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            fetchMedia();
          },
          backgroundColor: Colors.blue,
          child: const Icon(
            Icons.add,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
