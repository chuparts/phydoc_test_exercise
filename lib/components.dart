import 'package:flutter/material.dart';

Widget title(String text) {
  return Text(
    text,
    style: const TextStyle(fontSize: 32, fontWeight: FontWeight.w500),
  );
}

Widget cancelWarning(BuildContext context) {
  var textColor = const Color(0xff7F3004);
  return Container(
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
                style: TextStyle(fontSize: 16, color: textColor,),
              ),
              const SizedBox(height: 8),
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  elevation: 0,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                child: Text(
                  "Подробнее",
                  style: TextStyle(color: textColor, fontWeight: FontWeight.w500, fontSize: 16),
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}
