import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:phydoc_test_exercise/main.dart';
import 'package:phydoc_test_exercise/pages/format_page.dart';
import 'package:phydoc_test_exercise/providers.dart';
import 'package:provider/provider.dart';

class AppointmentOperationMain extends StatefulWidget {
  const AppointmentOperationMain({super.key});
  @override
  State<AppointmentOperationMain> createState() =>
      _AppointmentOperationMainState();
}

class _AppointmentOperationMainState extends State<AppointmentOperationMain> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          flexibleSpace: Center(
            child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(3, (index) {
                  var operationStepUpdateProvider =
                      context.watch<OperationStepUpdateProvider>();
                  return Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Container(
                      width: 28,
                      height: 6,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4),
                          color: index <= operationStepUpdateProvider.currentStep
                              ? colors["chosen"]
                              : colors["unchosen"]!),
                    ),
                  );
                })),
          ),
          actions: [
            IconButton(
                onPressed: () {},
                icon: const Image(image: AssetImage("assets/closing_icon.png")))
          ],
        ),
        body: const Column(
          children: [
            FormatPage(),
          ],
        ),
        bottomNavigationBar: BottomAppBar(
          color: Colors.white,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              OutlinedButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.arrow_back, color: Colors.black),
                label: const Text(
                  "Назад",
                  style: TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.w700),
                ),
                style: OutlinedButton.styleFrom(
                  minimumSize: Size.fromWidth(114),
                  side: BorderSide(color: Colors.grey.shade300, width: 2),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                ),
              ),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size.fromWidth(194),
                    backgroundColor: colors["chosen"],
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    padding:
                        const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                  ),
                  child: const Text(
                    "Дальше",
                    style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w700),
                  ),
                  onPressed: () {}),
            ],
          ),
        ),
      ),
    );
  }
}


// Center(
//             child: Padding(
//               padding: const EdgeInsets.fromLTRB(0, 16, 0, 16),
//               child: Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: List.generate(3, (index) {
//                     var operationStepUpdateProvider =
//                         context.watch<OperationStepUpdateProvider>();
//                     return Padding(
//                       padding: const EdgeInsets.all(4.0),
//                       child: Container(
//                         width: 28,
//                         height: 6,
//                         decoration: BoxDecoration(
//                             borderRadius: BorderRadius.circular(4),
//                             color:
//                                 index <= operationStepUpdateProvider.currentStep
//                                     ? colors["chosen"]
//                                     : colors["unchosen"]!),
//                       ),
//                     );
//                   })),
//             ),
//           ),