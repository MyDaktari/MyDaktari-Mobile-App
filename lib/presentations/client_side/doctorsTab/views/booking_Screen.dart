import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:my_daktari/constants/constants.dart';
import 'package:my_daktari/logic/bloc/client_bloc/book_appointment/book_appointment_bloc.dart';
import 'package:my_daktari/logic/bloc/client_bloc/doctor_time_slots/doctor_time_slots_bloc.dart';
import 'package:my_daktari/logic/cubit/booking_info/booking_info_cubit.dart';
import 'package:my_daktari/presentations/widgets/custom_loading.dart';
import 'package:my_daktari/constants/route.dart' as route;

class BookingScreen extends StatelessWidget {
  BookingScreen({super.key});

  // final SlotNotiifier _slotNotiifier = SlotNotiifier(value: '');
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(body: BlocBuilder<BookingInfoCubit, BookingInfoState>(
        builder: (context, bookingState) {
      return SafeArea(
        child: Column(
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
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      const Text('Book a time to schedule\nyour session',
                          textAlign: TextAlign.center),
                      CalendarDatePicker2(
                        config: CalendarDatePicker2Config(
                          calendarType: CalendarDatePicker2Type.single,
                          firstDate: DateTime.now(),
                          lastDate: DateTime(2024),
                          currentDate: DateTime.now(),
                        ),
                        value: [bookingState.date],
                        onValueChanged: (value) {
                          final selectedDate =
                              value.isNotEmpty == true ? value.first : null;

                          context
                              .read<BookingInfoCubit>()
                              .updateBookingInfo(date: selectedDate, time: '');
                          context.read<DoctorTimeSlotsBloc>().add(
                              LoadDoctorTimeSlots(
                                  doctorId: bookingState.doctorId.toString(),
                                  date: selectedDate ?? DateTime.now()));
                        },
                      ),
                      Container(
                        width: size.width,
                        height: size.height * .2,
                        child: BlocBuilder<DoctorTimeSlotsBloc,
                            DoctorTimeSlotsState>(
                          builder: (context, state) {
                            if (state is DoctorTimeSlotsLoading) {
                              return Center(child: CustomLoading());
                            } else if (state is DoctorTimeSlotsLoaded) {
                              if (state.timeAvailable.isEmpty) {
                                return Center(
                                  child: Text(
                                      'Sorry the doctor is not available on selected day'),
                                );
                              }
                              return Center(
                                child: Container(
                                  child: ListView(children: [
                                    Wrap(
                                      clipBehavior: Clip.antiAlias,
                                      runSpacing: 5,
                                      crossAxisAlignment:
                                          WrapCrossAlignment.center,
                                      alignment: WrapAlignment.center,
                                      children: state.timeAvailable
                                          .map((slot) => GestureDetector(
                                                onTap: () {
                                                  context
                                                      .read<BookingInfoCubit>()
                                                      .updateBookingInfo(
                                                          time: slot);
                                                },
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(6.0),
                                                  child: Container(
                                                    decoration: BoxDecoration(
                                                        color: context
                                                                    .read<
                                                                        BookingInfoCubit>()
                                                                    .state
                                                                    .time ==
                                                                slot
                                                            ? Theme.of(context)
                                                                .primaryColor
                                                            : Colors
                                                                .transparent,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(12)),
                                                    child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(8.0),
                                                        child: Text(slot,
                                                            style: TextStyle(
                                                                color: context
                                                                            .read<
                                                                                BookingInfoCubit>()
                                                                            .state
                                                                            .time ==
                                                                        slot
                                                                    ? Colors
                                                                        .white
                                                                    : Colors
                                                                        .black,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold))),
                                                  ),
                                                ),
                                              ))
                                          .toList(),
                                    ),
                                  ]),
                                ),
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
                              backgroundColor: primaryColor,
                              fixedSize: Size(size.width * .8, 50)),
                          onPressed: () {
                            print(bookingState.meetingOption.trim());
                            context.read<BookAppointmentBloc>().add(
                                BookNewAppointment(
                                    date: bookingState.date,
                                    time: bookingState.time,
                                    userId: bookingState.userId,
                                    doctorId: bookingState.doctorId,
                                    symptomID: bookingState.symptomID,
                                    description: bookingState.description,
                                    meetingOption: bookingState.meetingOption
                                        .toLowerCase()));
                          },
                          child: BlocConsumer<BookAppointmentBloc,
                              BookAppointmentState>(
                            listener: (context2, state) {
                              if (state is BookAppointmentLoaded) {
                                String amount = state.amount;
                                String id = state.appointmentID;
                                final cubitState =
                                    context.read<BookingInfoCubit>();

                                if (state.amount.isNotEmpty &&
                                    state.appointmentID.isNotEmpty) {
                                  print('hey');
                                  cubitState.updateBookingInfo(
                                      amount: amount, appointmentId: id);
                                } else {
                                  print('failed');
                                }
                                if (cubitState.state.time.isEmpty) {
                                  Fluttertoast.showToast(
                                      msg:
                                          'Kindly select a time for the booking first');
                                } else {
                                  Navigator.pushNamed(
                                      context, route.paymentScreen);
                                }
                              }
                              if (state is BookAppointmentLoadError) {
                                Fluttertoast.showToast(msg: state.message);
                              }
                            },
                            builder: (context, state) {
                              return state is BookAppointmentLoading
                                  ? CupertinoActivityIndicator(
                                      color: Colors.white)
                                  : Text('Proceed to payment');
                            },
                          ))
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    }));
  }
}
