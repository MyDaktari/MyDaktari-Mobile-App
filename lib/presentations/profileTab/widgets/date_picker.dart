import 'package:date_field/date_field.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:my_daktari/logic/cubit/update_profile/update_profile_cubit.dart';

class ProfileDatePicker extends StatelessWidget {
  const ProfileDatePicker({super.key, required this.date});
  final String date;
  String appendZero(int inputNumber) {
    return inputNumber.toString().length == 1
        ? '0$inputNumber'
        : inputNumber.toString();
  }

  @override
  Widget build(BuildContext context) {
    DateTime d = DateTime.parse(date);
    String formattedDate = DateFormat('yyyy-MM-dd').format(d);
    TextTheme textTheme = Theme.of(context).textTheme;
    final updateProfileCubit = context.watch<UpdateProfileCubit>();
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Birth Date',
              style: textTheme.displaySmall!
                  .copyWith(fontSize: 14, fontWeight: FontWeight.w700)),
          SizedBox(height: 10),
          Container(
            height: 50,
            width: size.width,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.grey, width: 1)),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: DateTimeField(
                dateFormat: DateFormat('yyyy-MM-dd'),
                mode: DateTimeFieldPickerMode.date,
                initialDate: DateTime(2005),
                firstDate: DateTime.now().subtract(Duration(days: 365 * 100)),
                lastDate: DateTime.now().subtract(Duration(days: 365 * 17)),
                decoration: InputDecoration(
                    hintText: formattedDate,
                    hintStyle: const TextStyle(
                        fontSize: 17.0,
                        color: Colors.black,
                        fontWeight: FontWeight.bold)),
                onDateSelected: (DateTime value) {
                  updateProfileCubit.updateBirthDate(value.toString());
                },
                dateTextStyle: const TextStyle(
                    fontSize: 17.0,
                    color: Colors.black,
                    fontWeight: FontWeight.bold),
                selectedDate: updateProfileCubit.state.birthDate.isEmpty
                    ? null
                    : DateFormat('yyyy-MM-dd')
                        .parse(updateProfileCubit.state.birthDate),
              ),
            ),
          ),
          const SizedBox(height: 15),
        ],
      ),
    );
  }
}
