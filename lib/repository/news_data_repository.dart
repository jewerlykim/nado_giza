import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import '../model/news_data_model.dart';
import 'package:http/http.dart' as httpPack;

class NewsDataRepository {
  static NewsDataRepository? _instance;
  static NewsDataRepository get instance {
    _instance ??= NewsDataRepository._();
    return _instance!;
  }

  NewsDataRepository._();

  get http => null;
// Local JSON 파일에서 데이터 로드
  Future<List<NewsData>> loadFromLocalJson() async {
    final data = await rootBundle.loadString('2023-06-05-16.json');
    final jsonResult = json.decode(data);
    final newsData = jsonResult as List;
    return newsData.map((news) => NewsData.fromJson(news)).toList();
  }

  // Local JSON 파일에서 키워드 데이터 로드
  Future<List<String>> loadKeywordsFromLocalJson() async {
    final data = await rootBundle.loadString('2023-06-01-15-keywords.json');
    final jsonResult = json.decode(data);
    final keywords = jsonResult as List;
    return keywords.map((keyword) => keyword.toString()).toList();
  }

// API에서 데이터 로드
  Future<List<NewsData>> loadFromApi() async {
    final response = await httpPack.get(
      Uri.parse('http://192.168.0.24:8000/getNews'),
      headers: {"Accept": "application/json"},
    );

    if (kDebugMode) {
      print("=====1");
    }

    var data = utf8.decode(response.bodyBytes);

    if (response.statusCode == 200) {
      final jsonResult = json.decode(data);
      final newsData = jsonResult as List;
      return newsData.map((news) => NewsData.fromJson(news)).toList();
    } else {
      throw Exception('Failed to load news data');
    }
  }
}
