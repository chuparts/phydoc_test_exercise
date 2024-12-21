import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FormatPage extends StatefulWidget {
  const FormatPage({super.key});

  @override
  State<FormatPage> createState() => _FormatPageState();
}

class _FormatPageState extends State<FormatPage> {
  int? _selectedIndex;

  final BoxDecoration _chosenContainer = BoxDecoration(
      border: Border.all(width: 2, color: const Color(0xff4435FF)),
      borderRadius: const BorderRadius.all(Radius.circular(12)),
      color: const Color(0xffECEBFF));
  final BoxDecoration _unchosenContainer = const BoxDecoration(
      borderRadius: BorderRadius.all(Radius.circular(12)),
      color: Color(0xffEFF2F5));

  final List<String> _titles = [
    "Онлайн-консультация",
    "Записаться в клинику",
    "Вызвать на дом"
  ];
  final List<String> _subtitles = [
    "Врач созвонится с вами и проведет консультацию в приложении.",
    "Врач будет ждать вас в своем кабинете в клинике.",
    "Врач сам приедет к вам домой в указанное время и дату."
  ];

  @override
  Widget build(BuildContext context) {
    return ListView(
        shrinkWrap: true,
        children: List.generate(3, (index) {
          final bool isSelected = _selectedIndex == index;
          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              GestureDetector(
                onTap: () {
                  setState(() {
                    _selectedIndex = index;
                  });
                },
                child: Container(
                  decoration:
                      isSelected ? _chosenContainer : _unchosenContainer,
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          _titles[index],
                          style: TextStyle(fontSize: 20),
                        ),
                        Text(_subtitles[index], style: TextStyle(fontSize: 16))
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 16,
              )
            ],
          );
        }));
  }
}
