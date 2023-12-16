import 'package:flutter/material.dart';
import 'package:teleplay/screens/home/models/search_movie_model.dart';
import 'package:flutter/services.dart';

class SearchResultsMovieTile extends StatelessWidget {
  const SearchResultsMovieTile({super.key, required this.searchMovieDataModel});
  final SearchMovieDataModel searchMovieDataModel;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.90,
      margin: const EdgeInsets.symmetric(vertical: 10),
      height: 100,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    searchMovieDataModel.time.substring(0, 16),
                    style: TextStyle(fontSize: 10, fontWeight: FontWeight.w600),
                  ),
                  Text(
                    overflow: TextOverflow.ellipsis,
                    searchMovieDataModel.title,
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    searchMovieDataModel.size,
                    style: TextStyle(fontSize: 14),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        children: [
                          Text(
                            "Seeds: ${searchMovieDataModel.seeds}",
                            style: const TextStyle(fontSize: 12),
                          ),
                          const SizedBox(
                            width: 3,
                          ),
                          const Icon(
                            Icons.thumb_up_rounded,
                            color: Colors.green,
                            size: 12,
                          )
                        ],
                      ),
                      Row(
                        children: [
                          Text(
                            "Peers: ${searchMovieDataModel.peers}",
                            style: const TextStyle(fontSize: 12),
                          ),
                          const SizedBox(
                            width: 4,
                          ),
                          const Icon(
                            Icons.thumb_down_rounded,
                            color: Colors.red,
                            size: 12,
                          )
                        ],
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          IconButton(
            onPressed: () async {
              await Clipboard.setData(
                  ClipboardData(text: searchMovieDataModel.magnet));
              print(searchMovieDataModel.magnet);
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                content: Text("Magnet link copied to clipboard"),
              ));
            },
            icon: const Icon(
              Icons.copy,
              size: 35,
            ),
          )
        ],
      ),
    );
  }
}
