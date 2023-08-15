import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../constants/enums.dart';
import '../../../../logic/cubit/update_profile/update_profile_cubit.dart';

class GenderMenu extends StatelessWidget {
  const GenderMenu({super.key, required this.gender});
  final Sex gender;

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    Size size = MediaQuery.of(context).size;
    final updateProfileCubit = context.watch<UpdateProfileCubit>();
    context.read<UpdateProfileCubit>().updateSex(gender);
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
                  onTap: () => updateProfileCubit.updateSex(sex),
                  child: Text(sex.name.substring(0, 1).toUpperCase() +
                      sex.name.substring(1))))
              .toList()),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Gender',
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
                padding: const EdgeInsets.only(left: 10, right: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    (updateProfileCubit.state.sex != Sex.undefined)
                        ? Text(updateProfileCubit.state.sex.name,
                            style: const TextStyle(
                                fontSize: 17.0,
                                color: Colors.black,
                                fontWeight: FontWeight.bold))
                        : Text(gender.name,
                            style: const TextStyle(
                                fontSize: 17.0,
                                color: Colors.black,
                                fontWeight: FontWeight.bold))
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
