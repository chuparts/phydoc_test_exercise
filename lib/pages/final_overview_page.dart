import 'package:flutter/material.dart';
import 'package:phydoc_test_exercise/components.dart';
import 'package:phydoc_test_exercise/main.dart';

class FinalOverviewPage extends StatelessWidget {
  const FinalOverviewPage({super.key});
  @override
  Widget build(BuildContext context) {
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
                )
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
        )
      ],
    ));
  }
}
