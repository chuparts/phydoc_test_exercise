import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:phydoc_test_exercise/components.dart';
import 'package:phydoc_test_exercise/main.dart';
import 'package:phydoc_test_exercise/providers.dart';
import 'package:provider/provider.dart';

class FormatPage extends StatefulWidget {
  const FormatPage({super.key});

  @override
  State<FormatPage> createState() => _FormatPageState();
}

class _FormatPageState extends State<FormatPage> {
  int? _selectedIndex;

  final BoxDecoration _chosenStyle = BoxDecoration(
      border: Border.all(width: 2, color: colors["chosen"]!),
      borderRadius: const BorderRadius.all(Radius.circular(12)),
      color: colors["chosen_bg"]!);
  final BoxDecoration _unchosenStyle = BoxDecoration(
      border: Border.all(width: 2, color: colors["unchosen"]!),
      borderRadius: const BorderRadius.all(Radius.circular(12)),
      color: colors["unchosen"]!);

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
    _selectedIndex = context.read<OperationProvider>().chosenFormatNum;
    var options = List.generate(3, (index) {
      final bool isSelected = _selectedIndex == index;
      return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          GestureDetector(
            onTap: () {
              setState(() {
                _selectedIndex = index;
                context.read<OperationProvider>().selectChosenFormat(_selectedIndex!);
              });
            },
            child: Container(
              decoration: isSelected ? _chosenStyle : _unchosenStyle,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      _titles[index],
                      style: const TextStyle(
                          fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    Text(_subtitles[index],
                        style: const TextStyle(fontSize: 16))
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
    });
    return Expanded(
      child: ListView(children: [
        title("Выберите формат приема"),
        const SizedBox(
          height: 16,
        ),
        for (var col in options) col,
      ]),
    );
  }
}
