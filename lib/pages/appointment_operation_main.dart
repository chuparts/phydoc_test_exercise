import 'package:flutter/material.dart';
import 'package:phydoc_test_exercise/api/appoint.dart';
import 'package:phydoc_test_exercise/components.dart';
import 'package:phydoc_test_exercise/main.dart';
import 'package:phydoc_test_exercise/pages/final_confirmation_page.dart';
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
    if (context.read<FormProvider>().formKey!.currentState!.validate()) {
      setState(() {
        currentStep++;
        context.read<OperationProvider>().setCurrentStep(currentStep);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    bool buttonIsClickable = true;

    if (currentStep == 2 &&
        context.watch<OperationProvider>().appointment == null) {
      setState(() {
        buttonIsClickable = false;
      });
    } else {
      setState(() {
        buttonIsClickable = true;
      });
    }
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
              if (currentStep == 3)
                Stack(
                  alignment: AlignmentDirectional.bottomCenter,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          color: colors["unchosen"]),
                      padding: const EdgeInsets.fromLTRB(16, 12, 12, 12),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Image.asset("assets/images/Visa.png"),
                              const SizedBox(
                                width: 16,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    "•••• 4515",
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    "03/24",
                                    style: TextStyle(
                                        color: colors["icon_fill"],
                                        fontSize: 14),
                                  )
                                ],
                              )
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              priceToString(
                                  "4500",
                                  const TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black)),
                              IconButton(
                                  onPressed: () {},
                                  icon: Icon(
                                    Icons.keyboard_arrow_down_rounded,
                                    color: colors["icon_fill"],
                                  ))
                            ],
                          )
                        ],
                      ),
                    )
                  ],
                )
            ],
          ),
        ),
        bottomNavigationBar: currentStep == 3
            ? BottomAppBar(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    IconButton(
                      icon: const Icon(
                        Icons.arrow_back,
                        color: Colors.black,
                      ),
                      style: IconButton.styleFrom(
                          fixedSize: const Size.fromRadius(28),
                          shape: CircleBorder(
                            side:
                                BorderSide(width: 2, color: colors["border"]!),
                          )),
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
                          backgroundColor: buttonIsClickable
                              ? colors["chosen"]
                              : const Color(0xffE4E7EC),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 32, vertical: 12),
                        ),
                        child: Text(
                          "Подтвердить и оплатить",
                          style: TextStyle(
                              color: buttonIsClickable
                                  ? Colors.white
                                  : const Color(0xff98A2B3),
                              fontSize: 16,
                              fontWeight: FontWeight.w700),
                        ),
                        onPressed: () {
                          var provider = context.read<OperationProvider>();
                          appoint(
                              provider.appointment!.id, provider.chosenFormat);
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const FinalConfirmationPage()));
                        }),
                  ],
                ),
              )
            : BottomAppBar(
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
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 12),
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
                          backgroundColor: buttonIsClickable
                              ? colors["chosen"]
                              : const Color(0xffE4E7EC),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 32, vertical: 12),
                        ),
                        child: Text(
                          "Дальше",
                          style: TextStyle(
                              color: buttonIsClickable
                                  ? Colors.white
                                  : const Color(0xff98A2B3),
                              fontSize: 16,
                              fontWeight: FontWeight.w700),
                        ),
                        onPressed: () {
                          if (currentStep < 3) {
                            if (currentStep == 1 &&
                                context.read<FormProvider>().selectedPage ==
                                    1) {
                              validateForm(context);
                            } else if (currentStep == 2) {
                              if (context
                                      .read<OperationProvider>()
                                      .appointment !=
                                  null) {
                                setState(() {
                                  currentStep++;
                                  context
                                      .read<OperationProvider>()
                                      .setCurrentStep(currentStep);
                                });
                              }
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
