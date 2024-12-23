import 'package:flutter/material.dart';
import 'package:phydoc_test_exercise/main.dart';
import 'package:phydoc_test_exercise/pages/final_overview_page.dart';
import 'package:phydoc_test_exercise/pages/format_page.dart';
import 'package:phydoc_test_exercise/pages/patient_page.dart';
import 'package:phydoc_test_exercise/pages/timeslot_page.dart';
import 'package:phydoc_test_exercise/providers.dart';
import 'package:provider/provider.dart';

class AppointmentOperationMain extends StatefulWidget {
  const AppointmentOperationMain({super.key});
  @override
  State<AppointmentOperationMain> createState() =>
      _AppointmentOperationMainState();
}

class _AppointmentOperationMainState extends State<AppointmentOperationMain> {

  List<Widget> operation = [
    const FormatPage(),
    const PatientPage(),
    const TimeslotPage(),
    const FinalOverviewPage()
  ];

  int currentPage = 0;

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
                  var operationProvider =
                      context.watch<OperationProvider>();
                  return Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Container(
                      width: 28,
                      height: 6,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4),
                          color:
                              index <= operationProvider.currentStep
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
        body: Column(
          children: [
            operation[currentPage]
          ],
        ),
        bottomNavigationBar: BottomAppBar(
          color: Colors.white,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              OutlinedButton.icon(
                icon: const Icon(Icons.arrow_back, color: Colors.black),
                label: const Text(
                  "Назад",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.w700),
                ),
                style: OutlinedButton.styleFrom(
                  minimumSize: const Size.fromWidth(114),
                  side: BorderSide(color: colors["border"]!, width: 2),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                ),
                onPressed: () {
                  if (currentPage > 0) {
                      setState(() {
                        currentPage--;
                        context.read<OperationProvider>().setCurrentStep(currentPage);
                      });
                    }
                },
              ),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size.fromWidth(194),
                    backgroundColor: colors["chosen"],
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 32, vertical: 12),
                  ),
                  child: const Text(
                    "Дальше",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w700),
                  ),
                  onPressed: () {
                    if (currentPage < 3) {
                      setState(() {
                        currentPage++;
                        context.read<OperationProvider>().setCurrentStep(currentPage);
                      });
                    }
                  }),
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