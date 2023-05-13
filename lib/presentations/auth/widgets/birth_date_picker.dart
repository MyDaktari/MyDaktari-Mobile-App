import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../services/auth_page_provider.dart';

class BirthDatePicker extends StatelessWidget {
  const BirthDatePicker({super.key});
  String appendZero(int inputNumber) {
    return inputNumber.toString().length == 1
        ? '0$inputNumber'
        : inputNumber.toString();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Consumer<AuthPageProvider>(builder: (context, authPageProvider, _) {
      return Column(
        children: [
          InkWell(
            borderRadius: BorderRadius.circular(15),
            onTap: () async {
              final date = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(1910),
                  lastDate: DateTime.now());
              authPageProvider.updateBirthDate(date ?? DateTime.now());
            },
            child: Container(
              width: size.width,
              height: 50,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(color: Colors.grey, width: 1.5)),
              child: Padding(
                padding: const EdgeInsets.only(left: 10, right: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Birth Date',
                      style: TextStyle(
                          color: Colors.grey, fontWeight: FontWeight.w300),
                    ),
                    Text(
                        '${appendZero(authPageProvider.birthDate.day)}/${appendZero(authPageProvider.birthDate.month)}/${authPageProvider.birthDate.year}')
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 15,
          ),
        ],
      );
    });
  }
}
