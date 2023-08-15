import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_daktari/constants/enums.dart';
import '../../../../constants/colors.dart';
import '../../../../constants/route.dart' as route;

import '../../../../logic/cubit/user_type/user_type_cubit.dart';

class UserTypeButton extends StatelessWidget {
  const UserTypeButton(
      {super.key, required this.userType, required this.title});
  final UserType userType;
  final String title;
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Container(
      width: size.width * 0.8,
      margin: EdgeInsets.only(top: 15),
      child: ElevatedButton(
        onPressed: () {
          context.read<UserTypeCubit>().switchToUser(userType: userType);
          Navigator.pushNamed(context, route.loginScreen);
        },
        style: ElevatedButton.styleFrom(
            backgroundColor: AppColor.primaryColor,
            padding: const EdgeInsets.all(15),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15))),
        child: Text(title, style: TextStyle(color: Colors.white)),
      ),
    );
  }
}
