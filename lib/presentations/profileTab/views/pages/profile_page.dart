import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:my_daktari/presentations/profileTab/widgets/profile_field.dart';
import 'package:my_daktari/presentations/profileTab/widgets/profile_picture.dart';
import '../../../../constants/enums.dart';

import '../../../../models/client.dart';
import '../../../../models/doctor.dart';

import '../../../../logic/bloc/auth_status/auth_status_bloc.dart';

class ProfilePage extends StatelessWidget {
  ProfilePage();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          centerTitle: true,
          title: Text('Basic info',
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 18)),
          elevation: 0),
      backgroundColor: Colors.white,
      body: BlocBuilder<AuthStatusBloc, AuthStatusState>(
        builder: (context, state) {
          if (state is UserAuthenticated) {
            final userType = state.userType;
            final userData = state.user;
            return SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    buildProfileFields(userType, userData),
                  ],
                ),
              ),
            );
          } else {
            return Container();
          }
        },
      ),
    );
  }

  Widget buildProfileFields(UserType userType, dynamic userData) {
    if (userType == UserType.client && userData is ClientModel) {
      final client = userData;
      return Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ProfilePicture(imageUrl: client.profileImage.toString()),
          ProfileField(title: 'Your Name', value: client.name.toString()),
          ProfileField(title: 'Email Address', value: client.email.toString()),
          ProfileField(title: 'Phone Number', value: client.phone.toString()),
          ProfileField(
              title: 'Date of Birth',
              value: DateFormat('d MMM y')
                  .format(DateTime.parse(client.dob.toString()))),
          ProfileField(title: 'Gender', value: client.gender.toString()),
        ],
      );
    } else if (userType == UserType.doctor && userData is DoctorModel) {
      final doctor = userData;
      return Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ProfilePicture(imageUrl: ''),
          ProfileField(title: 'Your Name', value: doctor.name.toString()),
          ProfileField(title: 'Email Address', value: doctor.email.toString()),
          ProfileField(title: 'Phone Number', value: doctor.phone.toString()),
          ProfileField(
              title: 'Date of Birth',
              value: DateFormat('d MMM y')
                  .format(DateTime.parse(doctor.dob.toString()))),
          ProfileField(title: 'Gender', value: doctor.gender.toString()),
        ],
      );
    } else {
      return Container(); // Empty container if the user type and data don't match
    }
  }
}
