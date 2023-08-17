import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:my_daktari/constants/enums.dart';
import 'package:my_daktari/logic/bloc/shared_bloc/authentication/authentication_bloc.dart';
import 'package:my_daktari/logic/cubit/page_update/page_update_cubit.dart';

import '../../../../constants/colors.dart';
import '../../../../logic/bloc/shared_bloc/auth_status/auth_status_bloc.dart';
import '../../../../logic/cubit/user_type/user_type_cubit.dart';

Future<dynamic> logOutDialog(BuildContext context) {
  return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Column(children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Mydaktari',
                    style: Theme.of(context)
                        .textTheme
                        .displayMedium!
                        .copyWith(color: AppColor.primaryColor, fontSize: 25)),
                IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: Icon(Icons.cancel,
                        size: 35, color: AppColor.primaryColor))
              ],
            ),
            const Divider(thickness: 2),
            Text('Are you sure you want to sign out? ',
                style: Theme.of(context)
                    .textTheme
                    .headlineSmall!
                    .copyWith(fontSize: 15)),
          ]),
          actionsAlignment: MainAxisAlignment.center,
          actions: [
            TextButton(
                onPressed: () => Navigator.pop(context),
                style: TextButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        side: BorderSide(color: AppColor.primaryColor),
                        borderRadius: BorderRadius.circular(10)),
                    fixedSize: const Size(100, 40)),
                child:
                    const Text('Stay', style: TextStyle(color: Colors.black))),
            TextButton(
              onPressed: () {
                print('Hello');
                if (context.read<UserTypeCubit>().state.userType !=
                    UserType.supplier) {
                  context.read<PageUpdateCubit>().setPageIndex(0);
                }
                context.read<AuthStatusBloc>().add(logUserOut());
                context
                    .read<AuthenticationBloc>()
                    .emit(AuthenticationInitial());
                Navigator.pop(context);
              },
              style: TextButton.styleFrom(
                  backgroundColor: AppColor.primaryColor,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  fixedSize: const Size(100, 40)),
              child: BlocConsumer<AuthStatusBloc, AuthStatusState>(
                listener: (context, state) {
                  if (state is UserAuthStatusError) {
                    Fluttertoast.showToast(msg: state.message);
                  }
                },
                builder: (context, state) {
                  if (state is AuthStatusLoding) {
                    return CupertinoActivityIndicator(color: Colors.white);
                  } else {
                    return const Text('Sign Out',
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.w700));
                  }
                },
              ),
            ),
          ],
        );
      });
}
