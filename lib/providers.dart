import 'package:flutter/cupertino.dart';
import 'package:phydoc_test_exercise/classes/appointment.dart';

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

  Appointment? appointment;

  void setAppointment(Appointment chosen) {
    appointment = chosen;
    notifyListeners();
  }
}


class FormProvider extends ChangeNotifier {
  int selectedPage = 0;
  GlobalKey<FormState>? formKey;
  String? name;

  void setFormKey(GlobalKey<FormState> key) {
    formKey = key;
  }

  void setSelectedPage(int page) {
    selectedPage = page;
  }
  void setName(String selectedName) {
    name = selectedName;
  }
}
