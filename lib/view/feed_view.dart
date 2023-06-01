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
      appBar: AppBar(
        title: const Text('대한민국 트렌드'),
        centerTitle: true,
      ),
      body: Consumer<NewsViewModel>(builder: (context, provider, child) {
        if (kDebugMode) {
          print('provider.newsData: ${provider.newsData}');
        }
        return GridView.builder(
          padding: const EdgeInsets.all(20.0),
          itemCount: provider.newsData?.length ?? 0,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            crossAxisSpacing: 20.0,
            mainAxisSpacing: 20.0,
            childAspectRatio: 1 / 1,
          ),
          itemBuilder: (BuildContext context, int index) {
            return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DetailView(
                      newsData: provider.newsData![index],
                    ),
                  ),
                );
              },
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                elevation: 10,
                child: Column(
                  children: [
                    Expanded(
                      child: ClipRRect(
                        borderRadius: const BorderRadius.vertical(
                          top: Radius.circular(15.0),
                        ),
                        child: CachedNetworkImage(
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
                      padding: const EdgeInsets.all(10.0),
                      child: Text(
                        '${provider.newsData?[index].title ?? ''}\n${provider.newsData?[index].analyze.mainKeyword ?? ''}',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                        textAlign: TextAlign.center,
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
