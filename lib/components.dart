import 'package:flutter/material.dart';
import 'package:phydoc_test_exercise/main.dart';

Widget title(String text) {
  return Text(
    text,
    style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
  );
}

class Warning extends StatefulWidget {
  const Warning({super.key});

  @override
  State<Warning> createState() => _WarningState();
}

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
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(
          height: 20,
        ),
        const SizedBox(height: 8),
      ],
    );
  }

class _WarningState extends State<Warning> {
  var textColor = const Color(0xff7F3004);
  bool visible = true;
  @override
  Widget build(BuildContext context) {
    return visible
        ? Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: const Color(0xffFCF0DB),
                ),
                padding: const EdgeInsets.all(16),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Icon(Icons.warning_rounded, color: Color(0xffDC6803)),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Отмена и изменение времени приема может стоить денег.",
                            style: TextStyle(
                              fontSize: 16,
                              color: textColor,
                            ),
                          ),
                          const SizedBox(height: 8),
                          ElevatedButton(
                            onPressed: () {
                              setState(() {
                                visible = false;
                              });
                            },
                            style: ElevatedButton.styleFrom(
                              elevation: 0,
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 12, vertical: 8),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16),
                              ),
                            ),
                            child: Text(
                              "Подробнее",
                              style: TextStyle(
                                  color: textColor,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 32,
              ),
            ],
          )
        : const SizedBox(
            height: 16,
          );
  }
}

List<String> weekDays = [
  "skipped",
  "понедельник",
  "вторник",
  "среда",
  "четверг",
  "пятница",
  "суббота",
  "воскресенье"
];
List<String> months = [
  "skipped",
  "января",
  "февраля",
  "марта",
  "апреля",
  "мая",
  "июня",
  "июля",
  "августа",
  "сентября",
  "октября",
  "ноября",
  "декабря"
];

String minutesToString(int minutes) {
  return minutes < 10 ? "0$minutes" : minutes.toString();
}

Widget priceToString(String price, TextStyle style) {
  return RichText(
    text: TextSpan(
      style: style,
      children: [
        TextSpan(text: price, style: const TextStyle(fontFamily: "Onest")),
        const TextSpan(text: "₸"),
      ],
    ),
  );
}
