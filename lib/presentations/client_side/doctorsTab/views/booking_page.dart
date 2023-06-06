import 'package:flutter/material.dart';
import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_daktari/logic/bloc/client_bloc/doctor_time_slots/doctor_time_slots_bloc.dart';
import 'package:my_daktari/presentations/widgets/custom_loading.dart';
import '../../../../models/doctor_profile_model.dart';

class DoctorBookingView extends StatelessWidget {
  DoctorBookingView(
      {super.key, required this.doctor, required this.meetingOption});
  final DoctorProfileModel doctor;
  final String meetingOption;

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
                      child: Image.asset('assets/images/my_daktari_blue.png')),
                ],
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: SizedBox(
                    height: size.height - 200,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        const SizedBox(height: 15),
                        const Text('Book a time to schedule\nyour session',
                            textAlign: TextAlign.center),
                        CalendarDatePicker2(
                          config: CalendarDatePicker2Config(
                              calendarType: CalendarDatePicker2Type.single,
                              firstDate: DateTime.now(),
                              lastDate: DateTime(2024),
                              currentDate: DateTime.now()),
                          value: const [],
                          onValueChanged: (value) {
                            print('#####################');
                            context.read<DoctorTimeSlotsBloc>().add(
                                LoadDoctorTimeSlots(
                                    doctorId: doctor.doctorID.toString(),
                                    date: value.first ?? DateTime.now()));
                            print(value);
                          },
                        ),
                        SizedBox(
                          width: size.width,
                          child: BlocBuilder<DoctorTimeSlotsBloc,
                              DoctorTimeSlotsState>(
                            builder: (context, state) {
                              if (state is DoctorTimeSlotsLoading) {
                                return CustomLoading();
                              } else if (state is DoctorTimeSlotsLoaded) {
                                return Wrap(
                                  runSpacing: 10,
                                  children: state.timeAvailable
                                      .map((slot) => GestureDetector(
                                            onTap: () =>
                                                _slotNotiifier.slot = slot,
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(6.0),
                                              child: Container(
                                                decoration: BoxDecoration(
                                                    color: val == slot
                                                        ? Theme.of(context)
                                                            .primaryColor
                                                        : Colors.transparent,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            12)),
                                                child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: Text(slot,
                                                        style: TextStyle(
                                                            color: slot == val
                                                                ? Colors.white
                                                                : Colors.black,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold))),
                                              ),
                                            ),
                                          ))
                                      .toList(),
                                );
                              } else if (state is DoctorTimeSlotsLoadError) {
                                return Center(child: Text(state.message));
                              } else {
                                return const SizedBox();
                              }
                            },
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
