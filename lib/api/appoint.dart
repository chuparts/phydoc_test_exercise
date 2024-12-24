import 'dart:convert';

import 'package:http/http.dart' as http;

Future<void> fetchAppointments(int id, String format) async {
  final Map<String, dynamic> requestBody = {
    'slot_id': id,
    'type': format,
  };
  try {
    final response = await http.post(
      Uri.parse("https://phydoc-test-2d45590c9688.herokuapp.com/appoint"),
      headers: {
        'Content-Type': 'application/json',
      },
      body: json.encode(requestBody),
    );

    if (response.statusCode != 200 && response.statusCode != 201) {
      throw Exception(
          "Не удалось создать запись. Ошибка ${response.statusCode}: ${response.body}");
    }
  } catch (e) {
    throw Exception("Не удалось создать запись. Ошибка $e");
  }
}
