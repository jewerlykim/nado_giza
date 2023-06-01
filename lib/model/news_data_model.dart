class NewsData {
  final String title;
  final String thumbnailUrl;
  final List<String> newsUrl;
  final List<String> pubDate;
  final String oneLineDescription;
  final int newsAmount;
  final String updatedTime;
  final int totalNewsSearched;
  final List<int> newsFrequencyInDuration;
  final List<String> originalContents;
  final List<TranslatedContent> translatedContents;
  final List<Summary> summary;
  final Analyze analyze;

  NewsData({
    required this.title,
    required this.thumbnailUrl,
    required this.newsUrl,
    required this.pubDate,
    required this.oneLineDescription,
    required this.newsAmount,
    required this.updatedTime,
    required this.totalNewsSearched,
    required this.newsFrequencyInDuration,
    required this.originalContents,
    required this.translatedContents,
    required this.summary,
    required this.analyze,
  });

  factory NewsData.fromJson(Map<String, dynamic> json) {
    var list1 = json['translated_contents'] as List;
    List<TranslatedContent> translatedContentList =
        list1.map((i) => TranslatedContent.fromJson(i)).toList();

    var list2 = json['summary'] as List;
    List<Summary> summaryList = list2.map((i) => Summary.fromJson(i)).toList();

    return NewsData(
      title: json['title'] as String,
      thumbnailUrl: json['thumbnail_url'] as String,
      newsUrl: List<String>.from(json['news_url']),
      pubDate: List<String>.from(json['pub_date']),
      oneLineDescription: json['one_line_description'] as String,
      newsAmount: json['news_amount'] as int,
      updatedTime: json['updated_time'] as String,
      totalNewsSearched: json['total_news_searched'] as int,
      newsFrequencyInDuration:
          List<int>.from(json['news_frequency_in_duration']),
      originalContents: List<String>.from(json['original_contents']),
      translatedContents: translatedContentList,
      summary: summaryList,
      analyze: Analyze.fromJson(json['analyze']),
    );
  }
}

class TranslatedContent {
  final String title;
  final String content;

  TranslatedContent({
    required this.title,
    required this.content,
  });

  factory TranslatedContent.fromJson(Map<String, dynamic> json) {
    return TranslatedContent(
      title: json['title'] as String,
      content: json['content'] as String,
    );
  }
}

class Summary {
  final String title;
  final String content;

  Summary({
    required this.title,
    required this.content,
  });

  factory Summary.fromJson(Map<String, dynamic> json) {
    return Summary(
      title: json['title'] as String,
      content: json['content'] as String,
    );
  }
}

class Analyze {
  final String mainKeyword;
  final String oneLine;
  final String factSummary;
  final String easySummary;
  final List<String> keywordsList;

  Analyze({
    required this.mainKeyword,
    required this.oneLine,
    required this.factSummary,
    required this.easySummary,
    required this.keywordsList,
  });

  factory Analyze.fromJson(Map<String, dynamic> json) {
    return Analyze(
      mainKeyword: json['main_keyword'] as String,
      oneLine: json['one_line'] as String,
      factSummary: json['fact_summary'] as String,
      easySummary: json['easy_summary'] as String,
      keywordsList: List<String>.from(json['keywords_list']),
    );
  }
}

class Keyword {
  final String keyword;

  Keyword({
    required this.keyword,
  });
}
