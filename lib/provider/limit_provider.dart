import 'package:flutter/cupertino.dart';

class LimitProvider extends ChangeNotifier {
  late int limit = 200;
  bool isLeftClicked = false;
  bool isRightClicked = false;
  bool isVoted = false;
  List<Map<String, dynamic>> something = [];
  List<int> ups = [];
  List<int> downs = [];

  void changeLimit(val) {
    limit = val;

    notifyListeners();
  }

  void changeLColor() {
    isLeftClicked = true;
    isRightClicked = false;
    notifyListeners();
  }

  void changeRColor() {
    isRightClicked = true;
    isLeftClicked = false;
    notifyListeners();
  }

  void addUps() {
    ups.add(1);
  }

  void addDowns() {
    downs.add(1);
  }
}
