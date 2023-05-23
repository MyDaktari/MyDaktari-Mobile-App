import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_daktari/models/client.dart';

import '../../../../../constants/enum_user_type.dart';
import '../../../../../logic/bloc/auth_status/auth_status_bloc.dart';
import '../../../../../models/doctor.dart';
import '../../../widgets/tab_header_bar.dart';
import '/constants/constants.dart' as constants;
import '/routes/app_route.dart' as routes;
import 'log_out_dialog.dart';

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
          return Container(
            height: size.height * .18,
            width: size.width,
            decoration: const BoxDecoration(color: constants.primaryColor),
            child: Padding(
              padding: const EdgeInsets.only(left: 28.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Expanded(
                    flex: 3,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 20,
                        ),
                        Text(
                            ((state.userType == UserType.client)
                                    ? (state.user as ClientModel).name
                                    : (state.user as DoctorModel).name)
                                .toString(),
                            style: const TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold)),
                        const SizedBox(height: 10),
                        Text(state.user?.email ?? '',
                            style: const TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                                letterSpacing: .8,
                                fontWeight: FontWeight.w600)),
                        ElevatedButton(
                          onPressed: () => logOutDialog(context),
                          child: Text('Sign Out'),
                        )
                      ],
                    ),
                  ),
                  Expanded(
                      flex: 2,
                      child: Image.asset('assets/images/male-user.png'))
                ],
              ),
            ),
          );
        } else {
          return TabHeader(
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
          );
        }
      }),
    );
  }
}
