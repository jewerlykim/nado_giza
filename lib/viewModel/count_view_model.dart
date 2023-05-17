import 'package:flutter/material.dart';

import '../model/count_model.dart';

class CountViewModel extends ChangeNotifier {
  final CountModel _countModel = CountModel();

  int get count => _countModel.count;

  void increment() {
    _countModel.count++;
    notifyListeners();
  }
}
