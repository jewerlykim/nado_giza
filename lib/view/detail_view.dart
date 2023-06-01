import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flip_card/flip_card.dart';

import '../model/news_data_model.dart';

class DetailView extends StatefulWidget {
  final NewsData newsData;

  const DetailView({Key? key, required this.newsData}) : super(key: key);

  @override
  _DetailViewState createState() => _DetailViewState();
}

class _DetailViewState extends State<DetailView> {
  @override
  Widget build(BuildContext context) {
    double paddingValue =
        MediaQuery.of(context).size.width * 0.05; // 5% padding

    return Scaffold(
      appBar: AppBar(
        title: Text(
            "${widget.newsData.title}, ${widget.newsData.analyze.mainKeyword}"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          // Add Padding
          padding: EdgeInsets.symmetric(horizontal: paddingValue, vertical: 20),
          child: Column(
            children: <Widget>[
              // 썸네일 이미지
              Card(
                elevation: 5, // Add shadow
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15), // Add border radius
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(15), // Add border radius
                  child: CachedNetworkImage(
                    imageUrl: widget.newsData.thumbnailUrl,
                    placeholder: (context, url) =>
                        const CircularProgressIndicator(),
                    errorWidget: (context, url, error) {
                      return const Icon(Icons.error);
                    },
                  ),
                ),
              ),
              const SizedBox(height: 10), // Add space
              // 한줄 요약
              Card(
                elevation: 5, // Add shadow
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15), // Add border radius
                ),
                child: Padding(
                  // Add internal padding
                  padding: const EdgeInsets.all(8.0),
                  child: ListTile(
                    title: Text(
                      "한줄 요약: ${widget.newsData.analyze.oneLine}",
                      style: const TextStyle(
                          fontWeight: FontWeight.bold), // Bold text
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 30), // Add space

              // 요약 <-> 쉬운 요약 FlipCard
              FlipCard(
                direction: FlipDirection.HORIZONTAL, // default
                front: Card(
                  elevation: 5, // Add shadow
                  shape: RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.circular(15), // Add border radius
                  ),
                  child: Padding(
                    // Add internal padding
                    padding: const EdgeInsets.all(8.0),
                    child: ListTile(
                      title: const Text('요약 (클릭하여 쉬운 요약을 보세요)',
                          style: TextStyle(
                              fontWeight: FontWeight.bold)), // Bold text
                      subtitle: Text(widget.newsData.analyze.factSummary),
                    ),
                  ),
                ),
                back: Card(
                  elevation: 5, // Add shadow
                  shape: RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.circular(15), // Add border radius
                  ),
                  child: Padding(
                    // Add internal padding
                    padding: const EdgeInsets.all(8.0),
                    child: ListTile(
                      title: const Text('쉬운 요약 (클릭하여 요약을 보세요)',
                          style: TextStyle(
                              fontWeight: FontWeight.bold)), // Bold text
                      subtitle: Text(widget.newsData.analyze.easySummary),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 10), // Add space

              // 키워드
              // Wrap(
              //   children: widget.newsData.analyze.keywordsList
              //       .map((keyword) => FlatButton(
              //             child: Text(keyword),
              //             onPressed: () {},
              //             shape: RoundedRectangleBorder(
              //               borderRadius: BorderRadius.circular(30.0),
              //               side: const BorderSide(color: Colors.grey),
              //             ),
              //           ))
              //       .toList(),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
