import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_daktari/models/client.dart';

import '../../../constants/enums.dart';
import '../../../logic/bloc/auth_status/auth_status_bloc.dart';
import '../../../models/doctor.dart';
import '../../widgets/tab_header_bar.dart';
import '/constants/constants.dart' as constants;
import '../../../constants/route.dart' as routes;

class ProfileSummary extends StatelessWidget {
  const ProfileSummary({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    TextTheme textTheme = Theme.of(context).textTheme;
    return Padding(
      padding: const EdgeInsets.only(top: 10.0),
      child: BlocBuilder<AuthStatusBloc, AuthStatusState>(
          builder: (context, state) {
        if (state is UserAuthenticated) {
          return SafeArea(
            child: Container(
              height: size.height * .1,
              width: size.width,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                      height: size.height * .08,
                      margin: EdgeInsets.symmetric(horizontal: 10),
                      decoration: BoxDecoration(
                          color: Colors.grey,
                          borderRadius: BorderRadius.circular(20)),
                      child: Image.asset('assets/images/male-user.png')),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                          ((state.userType == UserType.client)
                                  ? (state.user as ClientModel).name
                                  : (state.user as DoctorModel).name)
                              .toString(),
                          style: const TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                              fontWeight: FontWeight.bold)),
                      SizedBox(height: 5),
                      Text(state.user?.email ?? '',
                          style: const TextStyle(
                              color: Colors.black,
                              fontSize: 13,
                              letterSpacing: .8,
                              fontWeight: FontWeight.w600)),
                      // ElevatedButton(
                      //   onPressed: () => logOutDialog(context),
                      //   child: Text('Sign Out'),
                      // )
                    ],
                  ),
                  Spacer(),
                  Icon(Icons.calendar_month_outlined,
                      size: 35, color: Colors.grey),
                  Icon(Icons.notifications, size: 35, color: Colors.grey),
                ],
              ),
            ),
          );
        } else {
          return SafeArea(
            child: TabHeader(
              size: size,
              title: Text(
                'Create Your Profile,',
                style: textTheme.titleLarge?.copyWith(fontSize: 22),
              ),
              subtitle: Text('save your important information',
                  style: textTheme.titleMedium?.copyWith(
                      color: Colors.black,
                      fontSize: 13,
                      fontWeight: FontWeight.normal)),
              button: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(21)),
                      backgroundColor: constants.greenish),
                  onPressed: () {
                    Navigator.pushNamed(context, routes.loginScreen);
                  },
                  child: const Text('Sign In')),
              image: Image.asset('assets/images/telehealth.png'),
            ),
          );
        }
      }),
    );
  }
}
