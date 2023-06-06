import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flip_card/flip_card.dart';

import '../model/news_data_model.dart';

class DetailView extends StatefulWidget {
  final int currentIndex;
  final List<NewsData> newsDataList;

  const DetailView({
    Key? key,
    required this.currentIndex,
    required this.newsDataList,
  }) : super(key: key);

  @override
  DetailViewState createState() => DetailViewState();
}

class DetailViewState extends State<DetailView> {
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: widget.currentIndex);
    // _pageController = ScrollController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView.builder(
        controller: _pageController,
        itemCount: widget.newsDataList.length,
        itemBuilder: (context, index) {
          return DetailContentView(
            newsData: widget.newsDataList[index],
            currentIndex: index,
            newsDataList: widget.newsDataList,
          );
        },
      ),
    );
  }
}

class DetailContentView extends StatefulWidget {
  final NewsData newsData;
  final int currentIndex;
  final List<NewsData> newsDataList;

  const DetailContentView({
    Key? key,
    required this.newsData,
    required this.currentIndex,
    required this.newsDataList,
  }) : super(key: key);

  @override
  DetailContentViewState createState() => DetailContentViewState();
}

class DetailContentViewState extends State<DetailContentView> {
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
              getThumbnail(),
              const SizedBox(height: 10), // Add space
              // 한줄 요약
              getOneline(),

              const SizedBox(height: 10), // Add space

              // 요약 <-> 쉬운 요약 FlipCard
              FlipCardView(widget: widget),

              const SizedBox(height: 10),
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                widget.currentIndex > 0
                    ? buildPreviousButton()
                    : const Text(
                        "첫번째 뉴스입니다.",
                      ),
                widget.currentIndex < widget.newsDataList.length - 1
                    ? buildNextButton()
                    : const Text(
                        "마지막 뉴스입니다.",
                      ), // Add space
              ])
            ],
          ),
        ),
      ),
    );
  }

  Widget buildPreviousButton() {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => DetailContentView(
              newsData: widget.newsDataList[widget.currentIndex - 1],
              currentIndex: widget.currentIndex - 1,
              newsDataList: widget.newsDataList,
            ),
          ),
        );
      },
    );
  }

  Widget buildNextButton() {
    return IconButton(
      icon: const Icon(Icons.arrow_forward),
      onPressed: () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => DetailContentView(
              newsData: widget.newsDataList[widget.currentIndex + 1],
              currentIndex: widget.currentIndex + 1,
              newsDataList: widget.newsDataList,
            ),
          ),
        );
      },
    );
  }

  Card getThumbnail() {
    return Card(
      elevation: 5, // Add shadow
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15), // Add border radius
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15), // Add border radius
        child: CachedNetworkImage(
          imageUrl: widget.newsData.thumbnailUrl,
          placeholder: (context, url) => const CircularProgressIndicator(),
          errorWidget: (context, url, error) {
            return const Icon(Icons.error);
          },
        ),
      ),
    );
  }

  Card getOneline() {
    return Card(
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
            style: const TextStyle(fontWeight: FontWeight.bold), // Bold text
          ),
        ),
      ),
    );
  }
}

class FlipCardView extends StatefulWidget {
  const FlipCardView({super.key, required this.widget});

  final DetailContentView widget;

  @override
  State<FlipCardView> createState() => _FlipCardViewState();
}

class _FlipCardViewState extends State<FlipCardView> {
  @override
  Widget build(BuildContext context) {
    return FlipCard(
      direction: FlipDirection.VERTICAL, // default
      front: Material(
        elevation: 5, // Add shadow
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15), // Add border radius
        ),
        child: Padding(
          // Add internal padding
          padding: const EdgeInsets.all(8.0),
          child: ListTile(
            title: const Text('요약 (클릭하여 쉬운 요약을 보세요)',
                style: TextStyle(fontWeight: FontWeight.bold)), // Bold text
            subtitle: Text(widget.widget.newsData.analyze.factSummary),
          ),
        ),
      ),
      back: Material(
        elevation: 5, // Add shadow
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15), // Add border radius
        ),
        child: Padding(
          // Add internal padding
          padding: const EdgeInsets.all(8.0),
          child: ListTile(
            title: const Text('쉬운 요약 (클릭하여 요약을 보세요)',
                style: TextStyle(fontWeight: FontWeight.bold)), // Bold text
            subtitle: Text(widget.widget.newsData.analyze.easySummary),
          ),
        ),
      ),
    );
  }
}
