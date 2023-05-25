import 'package:date_field/date_field.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../logic/cubit/sign_up_helper/sign_up_helper_cubit.dart';

class BirthDatePicker extends StatelessWidget {
  BirthDatePicker({super.key});
  String appendZero(int inputNumber) {
    return inputNumber.toString().length == 1
        ? '0$inputNumber'
        : inputNumber.toString();
  }

  @override
  Widget build(BuildContext context) {
    final signUpHelperCubit = context.watch<SignUpHelperCubit>();
    Size size = MediaQuery.of(context).size;

    return Column(
      children: [
        Container(
          height: 50,
          width: size.width * .43,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              border: Border.all(color: Colors.grey, width: 1.5)),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: DateTimeField(
              dateFormat: DateFormat('yyyy-MM-dd'),
              mode: DateTimeFieldPickerMode.date,
              initialDate: DateTime(2005),
              firstDate: DateTime.now().subtract(Duration(days: 365 * 100)),
              lastDate: DateTime.now().subtract(Duration(days: 365 * 17)),
              decoration: InputDecoration(hintText: "Birth Date"),
              onDateSelected: (DateTime value) {
                signUpHelperCubit.updateBirthDate(value.toString());
              },
              selectedDate: signUpHelperCubit.state.birthDate.isEmpty
                  ? null
                  : DateFormat('yyyy-MM-dd')
                      .parse(signUpHelperCubit.state.birthDate),
            ),
          ),
        ),
        const SizedBox(height: 15),
      ],
    );
  }
}
