import 'package:flutter/material.dart';
import '../models/baby_model.dart';

class BabyProvider with ChangeNotifier {
  late Baby? _baby;

  Baby? get baby => _baby;

  void setBaby(Baby baby) {
    _baby = baby;
    notifyListeners();
  }

}
