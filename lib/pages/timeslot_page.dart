import 'package:flutter/material.dart';
import 'package:phydoc_test_exercise/api/fetch_appointments.dart';
import 'package:phydoc_test_exercise/classes/appointment.dart';
import 'package:phydoc_test_exercise/components.dart';
import 'package:phydoc_test_exercise/main.dart';
import 'package:phydoc_test_exercise/providers.dart';
import 'package:provider/provider.dart';

class DaySlots extends StatefulWidget {
  final DateTime date;
  final List<Appointment> slots;
  final Function(Appointment) onSlotSelected;
  final Appointment? selectedSlot;

  const DaySlots({
    super.key,
    required this.date,
    required this.slots,
    required this.onSlotSelected,
    required this.selectedSlot,
  });

  @override
  State<DaySlots> createState() => _DaySlotsState();
}

class _DaySlotsState extends State<DaySlots> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "${widget.date.day} ${months[widget.date.month]}, ${weekDays[widget.date.weekday]}",
          style: TextStyle(
              color: colors["icon_fill"],
              fontSize: 20,
              fontWeight: FontWeight.bold),
        ),
        const SizedBox(
          height: 16,
        ),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: widget.slots.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            childAspectRatio: 1.15,
            crossAxisCount: 4,
            crossAxisSpacing: 8.0,
            mainAxisSpacing: 8.0,
          ),
          itemBuilder: (context, index) {
            var time = widget.slots[index].dt;
            var price = widget.slots[index].price;
            Appointment slotId = widget.slots[index];

            bool isSelected = false;
            if (widget.selectedSlot != null) {
              isSelected = widget.selectedSlot!.id == slotId.id;
            }

            return GestureDetector(
              onTap: () {
                widget.onSlotSelected(slotId);
              },
              child: Container(
                decoration: BoxDecoration(
                  color: isSelected ? colors["chosen"] : colors["unchosen"],
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(12, 10, 12, 10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "${time.hour}:${minutesToString(time.minute)}",
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: isSelected
                                ? colors["chosen_bg"]
                                : Colors.black),
                      ),
                      priceToString(
                          price.toString(),
                          TextStyle(
                              fontSize: 16,
                              color: isSelected
                                  ? colors["chosen_bg"]
                                  : colors["icon_fill"])),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
        const SizedBox(
          height: 24,
        ),
      ],
    );
  }
}

class TimeslotPage extends StatefulWidget {
  const TimeslotPage({super.key});

  @override
  State<TimeslotPage> createState() => _TimeslotPageState();
}

class _TimeslotPageState extends State<TimeslotPage> {
  Appointment? selectedSlotId;
  bool moreOptionsShown = false;

  Map<DateTime, List<Appointment>> divideByDate(List<Appointment> list) {
    Map<DateTime, List<Appointment>> result = {};
    for (Appointment ap in list) {
      DateTime dateOnly = DateTime(ap.dt.year, ap.dt.month, ap.dt.day);
      result.putIfAbsent(dateOnly, () => []);
      result[dateOnly]!.add(ap);
    }
    return result;
  }

  @override
  Widget build(BuildContext context) {
    selectedSlotId = context.read<OperationProvider>().appointment;
    return Expanded(
      child: ListView(
        children: [
          title("Выберите дату и время"),
          const SizedBox(
            height: 16,
          ),
          const Warning(),
          FutureBuilder(
            future: fetchAppointments(
                context.read<OperationProvider>().chosenFormat),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return const Center(child: CircularProgressIndicator());
              }
              List<Appointment> appointments = snapshot.data!;
              Map<DateTime, List<Appointment>> dividedByDate =
                  divideByDate(appointments);
              var keys = dividedByDate.keys.toList();
              List<DateTime> before;
              List<DateTime>? after;
              if (keys.length > 2) {
                before = keys.sublist(0, 2);
                after = keys.sublist(2);
              } else {
                before = keys;
              }
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  for (var dt in before)
                    DaySlots(
                      date: dt,
                      slots: dividedByDate[dt]!,
                      selectedSlot: selectedSlotId,
                      onSlotSelected: (slotId) {
                        setState(() {
                          selectedSlotId = slotId;
                          context
                              .read<OperationProvider>()
                              .setAppointment(selectedSlotId!);
                        });
                      },
                    ),
                  if (!moreOptionsShown && after != null)
                    OutlinedButton(
                        style: OutlinedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 17),
                          side: BorderSide(color: colors["border"]!, width: 2),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(28),
                          ),
                        ),
                        onPressed: () {
                          setState(() {
                            moreOptionsShown = true;
                          });
                        },
                        child: const Center(
                            child: Text(
                          "Показать еще",
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                        ))),
                  if (moreOptionsShown)
                    for (var dt in after!)
                      DaySlots(
                        date: dt,
                        slots: dividedByDate[dt]!,
                        selectedSlot: selectedSlotId,
                        onSlotSelected: (slotId) {
                          setState(() {
                            selectedSlotId = slotId;
                            context
                                .read<OperationProvider>()
                                .setAppointment(selectedSlotId!);
                          });
                        },
                      ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}
