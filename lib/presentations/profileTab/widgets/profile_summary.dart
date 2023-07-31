import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../constants/constants.dart';
import '../../../constants/enums.dart';
import '../../../logic/bloc/auth_status/auth_status_bloc.dart';
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
                    margin: EdgeInsets.symmetric(horizontal: 15),
                    child: ClipOval(
                      clipBehavior: Clip.antiAlias,
                      child: Container(
                        decoration: BoxDecoration(),
                        height: 100,
                        width: 80,
                        child: CachedNetworkImage(
                          placeholder: (context, url) {
                            return CupertinoActivityIndicator();
                          },
                          errorWidget: (context, url, error) => const Image(
                              image: AssetImage('assets/images/male-user.png')),
                          fit: BoxFit.cover,
                          imageUrl: (state.userType == UserType.client)
                              ? client.profileImage.toString()
                              : doctor.image.toString(),
                        ),
                      ),
                    ),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                          ((state.userType == UserType.client)
                                  ? client.name
                                  : doctor.name)
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
                  Icon(Icons.notifications, size: 35, color: Colors.grey),
                  SizedBox(width: 10),
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
