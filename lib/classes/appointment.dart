class Appointment {
  int id;
  DateTime dt;
  int price;

  Appointment({required this.id, required this.dt, required this.price});

  factory Appointment.fromJson(Map<String, dynamic> json) {
    return Appointment(
      id: json['id'] as int,
      dt: DateTime.tryParse(json['datetime'])!,
      price: json['price'] as int
    );
  }
}