import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_daktari/constants/enums.dart';

import '../../../logic/cubit/charges_dropdown/drop_down_cubit.dart';

class ChargeDropDown extends StatelessWidget {
  const ChargeDropDown({super.key, required this.title});
  final String title;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final dropChargesCubit = context.watch<DropChargesCubit>();
    return InkWell(
      onTapDown: (TapDownDetails details) => showMenu<DropCharges>(
          context: context,
          position: RelativeRect.fromLTRB(
            details.globalPosition.dx,
            details.globalPosition.dy,
            details.globalPosition.dx + 100,
            details.globalPosition.dy + 100,
          ),
          items: DropCharges.values
              .map((dropValue) => PopupMenuItem<DropCharges>(
                  onTap: () {
                    if (title == 'Chat') {
                      dropChargesCubit.updateChatCharges(dropValue);
                    } else if (title == 'Phone Call') {
                      dropChargesCubit.updatePhoneCharges(dropValue);
                    } else {
                      dropChargesCubit.updateVideoCharges(dropValue);
                    }
                  },
                  child: Text(dropValue.name.replaceAll('_', ' '))))
              .toList()),
      child: Container(
        height: 50,
        width: size.width * .32,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          // border: Border.all(color: Colors.grey, width: 1.5),
        ),
        child: Padding(
          padding: const EdgeInsets.only(left: 10, right: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                  title == 'Chat'
                      ? dropChargesCubit.state.chat.name.replaceAll('_', ' ')
                      : (title == 'Phone Call')
                          ? dropChargesCubit.state.phone.name
                              .replaceAll('_', ' ')
                          : dropChargesCubit.state.video.name
                              .replaceAll('_', ' '),
                  style: const TextStyle(fontWeight: FontWeight.bold)),
              Icon(Icons.keyboard_arrow_down, size: 20)
            ],
          ),
        ),
      ),
    );
  }
}
