import 'package:flutter/material.dart';
import 'package:phydoc_test_exercise/pages/appointment_operation_main.dart';
import 'package:phydoc_test_exercise/providers.dart';
import 'package:provider/provider.dart';

Map<String, Color> colors = {
  "unchosen": const Color(0xffEFF2F5),
  "chosen": const Color(0xff4435FF),
  "chosen_bg": const Color(0xffECEBFF),
  "icon_fill" : const Color(0xff667085),
  "border" : const Color(0xffD0D5DD)
};

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
            create: (context) => OperationProvider())
      ],
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: AppointmentOperationMain(),
      ),
    );
  }
}
