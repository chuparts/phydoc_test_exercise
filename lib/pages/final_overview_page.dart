import 'package:flutter/material.dart';
import 'package:phydoc_test_exercise/classes/appointment.dart';
import 'package:phydoc_test_exercise/components.dart';
import 'package:phydoc_test_exercise/main.dart';
import 'package:phydoc_test_exercise/providers.dart';
import 'package:provider/provider.dart';

class FinalOverviewPage extends StatelessWidget {
  const FinalOverviewPage({super.key});
  @override
  Widget build(BuildContext context) {
    Appointment chosenAppointment =
        context.read<OperationProvider>().appointment!;
    List<String> slotLabel = ["ВРЕМЯ", "ДАТА", "ЦЕНА"];
    List<String> slotValue = [
      "${chosenAppointment.dt.hour}:${minutesToString(chosenAppointment.dt.minute)}",
      "${chosenAppointment.dt.day} ${months[chosenAppointment.dt.month]}",
      "${chosenAppointment.price}"
    ];

    List<String> chosenFormat = [
      "Онлайн-консультация",
      "Записаться в клинику",
      "Вызвать на дом"
    ];
    return Expanded(
        child: ListView(
      children: [
        title("Подтвердите запись"),
        const SizedBox(
          height: 16,
        ),
        const Warning(),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const CircleAvatar(
              radius: 36,
              backgroundImage: AssetImage("assets/images/avatar.png"),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Оксана Михайловна",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                Text("Офтальмолог",
                    style: TextStyle(fontSize: 16, color: colors["icon_fill"])),
                Row(
                  children: [
                    Icon(
                      Icons.star_rounded,
                      size: 18,
                      color: colors["icon_fill"],
                    ),
                    const SizedBox(
                      width: 4,
                    ),
                    Text(
                      "4,9",
                      style:
                          TextStyle(fontSize: 16, color: colors["icon_fill"]),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Icon(Icons.circle,
                          size: 4, color: colors["icon_fill"]),
                    ),
                    Text(
                      "Шымкент",
                      style:
                          TextStyle(fontSize: 16, color: colors["icon_fill"]),
                    )
                  ],
                ),
              ],
            ),
            OutlinedButton(
              style: OutlinedButton.styleFrom(
                padding:
                    const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                side: BorderSide(color: colors["border"]!, width: 2),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(28),
                ),
              ),
              onPressed: () {},
              child: Image.asset("assets/chat_bubble.png"),
            )
          ],
        ),
        const SizedBox(
          height: 16,
        ),
        Wrap(
          alignment: WrapAlignment.center,
          spacing: 12.0,
          runSpacing: 12.0,
          children: List.generate(slotLabel.length, (index) {
            return Container(
              decoration: BoxDecoration(
                color: colors["unchosen"],
                borderRadius: BorderRadius.circular(16),
              ),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      slotLabel[index],
                      style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: colors["icon_fill"]),
                    ),
                    if (index != 2)
                      Text(
                        slotValue[index],
                        style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.black),
                      ),
                    if (index == 2)
                      priceToString(
                        slotValue[index],
                        const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.black),
                      )
                  ],
                ),
              ),
            );
          }),
        ),
        const SizedBox(
          height: 24,
        ),
        labelAndValue("Формат приема:",
            chosenFormat[context.read<OperationProvider>().chosenFormatNum]),
        labelAndValue("Пациент:", context.read<FormProvider>().name!),
      ],
    ));
  }
}



// GridView.builder(
//             physics: NeverScrollableScrollPhysics(),
//             shrinkWrap: true,
//             gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//               crossAxisCount: 3,
//               crossAxisSpacing: 12.0,
//               mainAxisSpacing: 12.0,
//             ),
//             itemCount: 3,
//             itemBuilder: (context, index) {
//               return Container(
//                 decoration: BoxDecoration(
//                   color: colors["unchosen"],
//                   borderRadius: BorderRadius.circular(16),
//                 ),
//                 child: Padding(
//                   padding: const EdgeInsets.fromLTRB(12, 10, 12, 10),
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.start,
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(
//                         slotLabel[index],
//                         style: TextStyle(
//                             fontSize: 12,
//                             fontWeight: FontWeight.bold,
//                             color: colors["icon_fill"]),
//                       ),
//                       if (index != 2)
//                         Text(
//                           slotValue[index],
//                           style: const TextStyle(
//                               fontSize: 20,
//                               fontWeight: FontWeight.bold,
//                               color: Colors.black),
//                         ),
//                       if (index == 2)
//                         priceToString(
//                           slotValue[index],
//                           const TextStyle(
//                               fontSize: 20,
//                               fontWeight: FontWeight.bold,
//                               color: Colors.black),
//                         )
//                     ],
//                   ),
//                 ),
//               );
//             }),