import 'package:flutter/cupertino.dart';

class OperationProvider extends ChangeNotifier {
  int currentStep = 0;

  void setCurrentStep(int step) {
    currentStep = step;
    notifyListeners();
  }

  int chosenFormatNum = 0;
  String chosenFormat = "online";

  void selectChosenFormat(int selectedIndex) {
    if (selectedIndex == 0) {
      chosenFormat = "online";
    }
    else {
      chosenFormat = "offline";
    }
    chosenFormatNum = selectedIndex;
    notifyListeners();
  }
}

