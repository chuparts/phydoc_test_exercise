import 'package:flutter/material.dart';
import 'package:phydoc_test_exercise/api/fetch_appointments.dart';
import 'package:phydoc_test_exercise/classes/appointment.dart';
import 'package:phydoc_test_exercise/components.dart';
import 'package:phydoc_test_exercise/providers.dart';
import 'package:provider/provider.dart';

class TimeslotPage extends StatefulWidget {
  const TimeslotPage({super.key});

  @override
  State<TimeslotPage> createState() => _TimeslotPageState();
}

class _TimeslotPageState extends State<TimeslotPage> {
  
  Map<DateTime, List<Appointment>> divideByDate(List<Appointment> list) {
    Map<DateTime, List<Appointment>> result = {};
    for (Appointment ap in list) {
      if (!result.containsKey(ap.dt))
      {
        result[ap.dt] = [];
      }
      result[ap.dt]!.add(ap);
    }
    return result;
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      children: [
        title("Выберите дату и время"),
        const SizedBox(
          height: 16,
        ),
        cancelWarning(context),
        FutureBuilder(
            future: fetchAppointments(
                context.read<OperationProvider>().chosenFormat),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return const Center(child: CircularProgressIndicator());
              }
              List<Appointment> appointments = snapshot.data!;
              Map<DateTime, List<Appointment>> dividedByDate = divideByDate(appointments);
              
              return ListView(
                shrinkWrap: true,
                children: [
                  for (Appointment ap in appointments) Text(ap.dt.toString())
                ],
              );
            })
      ],
    );
  }
}
