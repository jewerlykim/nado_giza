import 'package:flutter/foundation.dart';
import 'package:nado_giza/model/news_data_model.dart';
import 'package:nado_giza/repository/news_data_repository.dart';

class NewsViewModel extends ChangeNotifier {
  List<NewsData>? newsData;
  List<String>? keywords;

  NewsViewModel() {
    loadNews();
    loadKeywords();
  }

  loadNews() async {
    try {
      // Local JSON 파일에서 데이터 로드
      newsData = await NewsDataRepository.instance.loadFromLocalJson();
      // API에서 데이터 로드
      // newsData = await loadFromApi();

      notifyListeners();
    } catch (e) {
      // 에러 처리
    }
  }

  loadKeywords() async {
    try {
      // Local JSON 파일에서 키워드 데이터 로드
      keywords = await NewsDataRepository.instance.loadKeywordsFromLocalJson();

      notifyListeners();
    } catch (e) {
      // 에러 처리
    }
  }
}
