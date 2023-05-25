import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../constants/enums.dart';
import '../../../logic/cubit/sign_up_helper/sign_up_helper_cubit.dart';

class SexMenu extends StatelessWidget {
  const SexMenu({super.key, required this.size});

  final Size size;

  @override
  Widget build(BuildContext context) {
    final signUpHelperCubit = context.watch<SignUpHelperCubit>();
    return InkWell(
      onTapDown: (TapDownDetails details) => showMenu<Sex>(
          context: context,
          position: RelativeRect.fromLTRB(
            details.globalPosition.dx,
            details.globalPosition.dy,
            details.globalPosition.dx + 100,
            details.globalPosition.dy + 100,
          ),
          items: Sex.values
              .where((element) => element != Sex.undefined)
              .map((sex) => PopupMenuItem<Sex>(
                  onTap: () => signUpHelperCubit.updateSex(sex),
                  child: Text(sex.name.substring(0, 1).toUpperCase() +
                      sex.name.substring(1))))
              .toList()),
      child: Container(
        height: 50,
        width: size.width * .43,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            border: Border.all(color: Colors.grey, width: 1.5)),
        child: Padding(
          padding: const EdgeInsets.only(left: 10, right: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Sex',
                  style: TextStyle(
                      color: Colors.grey, fontWeight: FontWeight.w300)),
              if (signUpHelperCubit.state.sex != Sex.undefined)
                Text(signUpHelperCubit.state.sex.name,
                    style: const TextStyle(fontWeight: FontWeight.bold)),
            ],
          ),
        ),
      ),
    );
  }
}
