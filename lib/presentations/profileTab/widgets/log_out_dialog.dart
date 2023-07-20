import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:my_daktari/constants/constants.dart';
import 'package:my_daktari/logic/bloc/authentication/authentication_bloc.dart';
import 'package:my_daktari/logic/cubit/page_update/page_update_cubit.dart';

import '../../../logic/bloc/auth_status/auth_status_bloc.dart';

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
                        .copyWith(color: primaryColor, fontSize: 25)),
                IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon:
                        const Icon(Icons.cancel, size: 35, color: primaryColor))
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
                        side: const BorderSide(color: primaryColor),
                        borderRadius: BorderRadius.circular(10)),
                    fixedSize: const Size(100, 40)),
                child:
                    const Text('Stay', style: TextStyle(color: Colors.black))),
            TextButton(
              onPressed: () {
                context.read<PageUpdateCubit>().setPageIndex(0);
                context.read<AuthStatusBloc>().add(logUserOut());
                context
                    .read<AuthenticationBloc>()
                    .emit(AuthenticationInitial());
                Navigator.pop(context);
              },
              style: TextButton.styleFrom(
                  backgroundColor: primaryColor,
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
