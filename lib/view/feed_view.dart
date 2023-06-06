import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:nado_giza/view/detail_view.dart';
import 'package:nado_giza/viewModel/news_data_viewmodel.dart';
import 'package:provider/provider.dart';

class FeedView extends StatelessWidget {
  const FeedView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlue[50],
      body: Consumer<NewsViewModel>(builder: (context, provider, child) {
        if (kDebugMode) {
          print("=====2");
        }

        final newsDataList = provider.newsData ?? [];

        if (newsDataList.isEmpty) {
          provider.loadNews();
        }

        return GridView.builder(
          padding: const EdgeInsets.all(2.0),
          itemCount: provider.newsData?.length ?? 0,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            // crossAxisSpacing: 10.0,
            // mainAxisSpacing: 10.0,
            childAspectRatio: 1 / 1.5,
          ),
          itemBuilder: (BuildContext context, int index) {
            return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DetailView(
                      currentIndex: index,
                      newsDataList: newsDataList,
                    ),
                  ),
                );
              },
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5.0),
                ),
                elevation: 10,
                child: Column(
                  children: [
                    Expanded(
                      child: ClipRRect(
                        borderRadius: const BorderRadius.vertical(
                          top: Radius.circular(5.0),
                        ),
                        child: CachedNetworkImage(
                          fit: BoxFit.fitHeight,
                          imageUrl: provider.newsData?[index].thumbnailUrl ??
                              'sample.png',
                          placeholder: (context, url) =>
                              const CircularProgressIndicator(),
                          errorWidget: (context, url, error) {
                            if (kDebugMode) {
                              print(error);
                            }
                            return const Icon(Icons.error);
                          },
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Center(
                        child: Text(
                          '${provider.newsData?[index].title ?? ''}\n${provider.newsData?[index].analyze.mainKeyword ?? ''}',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                          ),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      }),
    );
  }
}
