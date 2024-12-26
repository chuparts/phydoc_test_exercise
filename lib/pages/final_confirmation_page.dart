import 'package:flutter/material.dart';
import 'package:phydoc_test_exercise/main.dart';
import 'package:phydoc_test_exercise/pages/appointment_operation_main.dart';

class FinalConfirmationPage extends StatelessWidget {
  const FinalConfirmationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colors["chosen"],
      body: const Padding(
        padding: EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Вы записаны на прием!",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 32,
                  fontWeight: FontWeight.bold),
            ),
            Text(
              "Мы отправим вам уведмление чтобы вы не забыли о приеме.",
              style: TextStyle(color: Colors.white, fontSize: 16),
            ),
            SizedBox(
              height: 8,
            ),
            Text(
                "Если захотите изменить или отменить запись, вы можете сделать на странице с записями.",
                style: TextStyle(color: Colors.white, fontSize: 16))
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        elevation: 0,
        color: colors["chosen"],
        child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(28),
              ),
              padding: const EdgeInsets.all(16),
            ),
            child: const Text(
              "Хорошо",
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: Colors.black),
            ),
            onPressed: () {
              Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const AppointmentOperationMain()));
            }),
      ),
    );
  }
}
