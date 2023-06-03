import 'package:flutter/material.dart';
import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import '../../../../models/doctor_profile_model.dart';

class DoctorBookingView extends StatelessWidget {
  DoctorBookingView({super.key, required this.doctor});
  final DoctorProfileModel doctor;
  final List<String> _availablSlots = [
    '11:00 AM',
    '02:30 PM',
    '03:30 PM',
    '11:45 AM',
    '09:00 AM',
    '01:30 PM',
    '02:00 PM',
    '04:00 PM',
  ];
  final SlotNotiifier _slotNotiifier = SlotNotiifier(value: '');
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return ValueListenableBuilder(
        valueListenable: _slotNotiifier,
        builder: (context, val, _) {
          return Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: const Icon(Icons.arrow_back_ios)),
                  Padding(
                    padding: const EdgeInsets.only(right: 45.0),
                    child: Image.asset('assets/images/my_daktari_blue.png'),
                  ),
                ],
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: SizedBox(
                    height: size.height - 200,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        const SizedBox(
                          height: 15,
                        ),
                        const Text(
                          'Book a time to schedule\nyour session',
                          textAlign: TextAlign.center,
                        ),
                        CalendarDatePicker2(
                          config: CalendarDatePicker2Config(
                              calendarType: CalendarDatePicker2Type.single,
                              firstDate: DateTime.now(),
                              lastDate: DateTime(2024),
                              currentDate: DateTime.now()),
                          value: const [],
                          onValueChanged: (value) {},
                        ),
                        SizedBox(
                          width: size.width,
                          child: Wrap(
                            runSpacing: 10,
                            children: _availablSlots
                                .map((slot) => GestureDetector(
                                      onTap: () => _slotNotiifier.slot = slot,
                                      child: Padding(
                                        padding: const EdgeInsets.all(6.0),
                                        child: Container(
                                          decoration: BoxDecoration(
                                              color: val == slot
                                                  ? Theme.of(context)
                                                      .primaryColor
                                                  : Colors.transparent,
                                              borderRadius:
                                                  BorderRadius.circular(12)),
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text(
                                              slot,
                                              style: TextStyle(
                                                  color: slot == val
                                                      ? Colors.white
                                                      : Colors.black,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ))
                                .toList(),
                          ),
                        ),
                        ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor:
                                    Theme.of(context).primaryColor),
                            onPressed: () {},
                            child: const Text('Proceed to payment'))
                      ],
                    ),
                  ),
                ),
              ),
            ],
          );
        });
  }
}

class SlotNotiifier extends ValueNotifier<String> {
  SlotNotiifier({required String value}) : super(value);

  set slot(String value) {
    this.value = value;
    notifyListeners();
  }
}
