import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:my_daktari/logic/bloc/shared_bloc/auth_status/auth_status_bloc.dart';
//import route as route
import '../../../../constants/route.dart' as route;
import 'package:my_daktari/presentations/shared_ui/profileTab/widgets/profile_summary.dart';
import '../../../../constants/colors.dart';

class AyaTab extends StatelessWidget {
  const AyaTab({super.key});

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    Size size = MediaQuery.of(context).size;
    return Column(
      children: [
        ProfileSummary(),
        Expanded(
            child: Image.asset('assets/images/aya-half.png',
                fit: BoxFit.fitHeight)),
        Expanded(
          child: Container(
            width: size.width,
            decoration: BoxDecoration(
                color: AppColor.primaryColor,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(25),
                    topRight: Radius.circular(25))),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text('Hello, I\'m Aya',
                      style:
                          textTheme.titleLarge?.copyWith(color: Colors.white)),
                  Text(
                    'Your very own MyDaktari Assistant. I work 24/7 to enhance your MyDaktari experience and available at the touch of a button',
                    textAlign: TextAlign.center,
                    style: textTheme.bodyLarge
                        ?.copyWith(color: Colors.white, fontSize: 16),
                  ),
                  BlocBuilder<AuthStatusBloc, AuthStatusState>(
                    builder: (context, state) {
                      return ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: AppColor.lightgreen),
                          onPressed: false //state is UserAuthenticated
                              ? () => Navigator.pushNamed(
                                  context, route.chatBotScreen)
                              : () =>
                                  Fluttertoast.showToast(msg: 'Coming Soon!'),
                          // Navigator.pushNamed(
                          //     context, route.loginScreen),
                          child: const Text('Continue to Chat'));
                    },
                  )
                ],
              ),
            ),
          ),
        )
      ],
    );
  }
}
