import 'dart:convert';

import 'package:phydoc_test_exercise/classes/appointment.dart';
import 'package:http/http.dart' as http;

Future<List<Appointment>> fetchAppointments(String format) async {
  try {
    final response = await http.get(Uri.parse(
        'https://phydoc-test-2d45590c9688.herokuapp.com/get_schedule?type=$format'));
    if (response.statusCode == 200) {
      List<Appointment> appointments = [];
      for (dynamic f in jsonDecode(response.body)['slots']) {
        appointments.add(Appointment.fromJson(f));
      }
      return appointments;
    } else {
      throw Exception('Ошибка при получении данных с API');
    }
  } catch (e) {
    throw Exception('Ошибка при получении данных с API. Сообщение ошибки: $e');
  }
}
