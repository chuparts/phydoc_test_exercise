import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:phydoc_test_exercise/components.dart';
import 'package:phydoc_test_exercise/main.dart';

class PatientPage extends StatefulWidget {
  const PatientPage({super.key});

  @override
  State<PatientPage> createState() => _PatientPageState();
}

class _PatientPageState extends State<PatientPage> {
  int selectedPage = 0;

  BoxDecoration chosenPatient = BoxDecoration(
    color: colors["chosen"],
    borderRadius: BorderRadius.circular(10),
  );

  Widget labelAndValue(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(fontSize: 16, color: colors["icon_fill"]),
        ),
        const SizedBox(
          height: 8,
        ),
        Text(
          value,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
        ),
        const SizedBox(
          height: 20,
        )
      ],
    );
  }

  Widget selfPage() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        labelAndValue("Имя и фамилия:", "Иванов Иван"),
        const SizedBox(height: 8),
        labelAndValue("ИИН:", "041115486195"),
        const SizedBox(height: 8),
        labelAndValue("Номер телефона:", "+7 707 748 4815"),
        const SizedBox(height: 8),
        labelAndValue("Адрес прописки:", "ул. Гани Иляева 15"),
      ],
    );
  }

  Widget customFormField(
    String label,
    String hintText,
    String? Function(String?)? givenValidator,
    String type,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(fontSize: 16),
        ),
        const SizedBox(
          height: 8,
        ),
        TextFormField(
          decoration: InputDecoration(
              hintText: hintText,
              hintStyle: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 16,
                  color: colors["icon_fill"]),
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(width: 2, color: colors["border"]!)),
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(width: 2, color: colors["chosen"]!))),
          validator: givenValidator,
          inputFormatters: type == "PhoneNumber"
              ? [
                  MaskTextInputFormatter(
                    mask: "+# ### ### ####",
                    filter: {"#": RegExp('[0-9]')},
                  )
                ]
              : (type == "IIN"
                  ? [
                      MaskTextInputFormatter(
                        mask: "############",
                        filter: {"#": RegExp('[0-9]')},
                      )
                    ]
                  : null),
        ),
        const SizedBox(
          height: 16,
        ),
      ],
    );
  }

  Widget someonePage() {
    return Form(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            customFormField("Имя и фамилия", "Иванов Иван", (String? value) {
              if (value!.isEmpty) {
                return "Введите имя и фамилию";
              }
              return null;
            }, "Name"),
            customFormField("ИИН", "Введите ИИН человека", (String? value) {
              if (value!.isEmpty) {
                return "Введите ИИН";
              }
              if (value.length < 12) {
                return "ИИН состоит из 12 цифр";
              }
              return null;
            }, "IIN"),
            customFormField("Номер телефона", "Введите номер телефона",
                (String? value) {
              if (value!.isEmpty) {
                return "Введите номер телефона";
              }
              return null;
            }, "PhoneNumber"),
            customFormField("Адрес", "Адрес прописки", (String? value) {
              if (value!.isEmpty) {
                return "Введите адрес";
              }
              return null;
            }, "Address"),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          title("Выберите кого хотите записать"),
          const SizedBox(
            height: 32,
          ),
          Container(
            decoration: BoxDecoration(
              border: Border.all(width: 1, color: colors["border"]!),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Padding(
                  padding: const EdgeInsets.all(6.0),
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedPage = 0;
                      });
                    },
                    child: Container(
                      decoration: selectedPage == 0 ? chosenPatient : null,
                      width: 148,
                      height: 46,
                      child: Center(
                        child: Text(
                          "Себя",
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                              color: selectedPage == 0
                                  ? Colors.white
                                  : Colors.black),
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(6.0),
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedPage = 1;
                      });
                    },
                    child: Container(
                      decoration: selectedPage == 1 ? chosenPatient : null,
                      width: 148,
                      height: 46,
                      child: Center(
                        child: Text(
                          "Другого",
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                              color: selectedPage == 1
                                  ? Colors.white
                                  : Colors.black),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          selectedPage == 0 ? selfPage() : someonePage(),
        ],
      ),
    );
  }
}
