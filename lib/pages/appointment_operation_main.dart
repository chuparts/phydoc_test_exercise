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

  int currentStep = 0;

  void validateForm(BuildContext context) {
    if (!context.read<FormProvider>().formKey!.currentState!.validate()) {
      showDialog(
          context: context,
          builder: (context) => AlertDialog(
                title: const Text("Заполните все поля"),
                actions: [
                  TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text("Ок"))
                ],
              ));
    } else {
      setState(() {
        currentStep++;
        context.read<OperationProvider>().setCurrentStep(currentStep);
      });
    }
  }

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
                  var operationProvider = context.watch<OperationProvider>();
                  return Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Container(
                      width: 28,
                      height: 6,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4),
                          color: index <= operationProvider.currentStep
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
        body: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              operation[currentStep],
            ],
          ),
        ),
        bottomNavigationBar: BottomAppBar(
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
                  if (currentStep > 0) {
                    setState(() {
                      currentStep--;
                      context
                          .read<OperationProvider>()
                          .setCurrentStep(currentStep);
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
                    if (currentStep < 3) {
                      if (currentStep == 1 &&
                          context.read<FormProvider>().selectedPage == 1) {
                        validateForm(context);
                      } else if (currentStep == 2 &&
                          context.read<OperationProvider>().appointmentId ==
                              null) {
                        showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                                  title: const Text("Выберите запись"),
                                  actions: [
                                    TextButton(
                                        onPressed: () => Navigator.pop(context),
                                        child: const Text("Ок"))
                                  ],
                                ));
                      } else {
                        setState(() {
                          currentStep++;
                          context
                              .read<OperationProvider>()
                              .setCurrentStep(currentStep);
                        });
                      }
                    }
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
