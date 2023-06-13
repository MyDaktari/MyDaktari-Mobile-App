import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../constants/enums.dart';

import '../../../models/client.dart';
import '../../../models/doctor.dart';

import '../../../logic/bloc/auth_status/auth_status_bloc.dart';

class ProfilePage extends StatelessWidget {
  ProfilePage();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Profile',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 24,
          ),
        ),
        elevation: 0,
      ),
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
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 16.0),
                      child: Text(
                        userType == UserType.client
                            ? 'Client Profile'
                            : 'Doctor Profile',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.blue,
                        ),
                      ),
                    ),
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          buildProfileField('User ID', client.userID.toString()),
          buildProfileField('Name', client.name),
          buildProfileField('Email', client.email),
          buildProfileField('Address', client.address),
          buildProfileField('Date of Birth', client.dob),
          buildProfileField('Phone', client.phone),
          buildProfileField('Gender', client.gender),
        ],
      );
    } else if (userType == UserType.doctor && userData is DoctorModel) {
      final doctor = userData;
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          buildProfileField('Name', doctor.name),
          buildProfileField('ID', doctor.id.toString()),
          buildProfileField('Email', doctor.email),
          buildProfileField('Phone', doctor.phone),
          buildProfileField('Date of Birth', doctor.dob),
          buildProfileField('Gender', doctor.gender),
          buildProfileField('Speciality', doctor.speciality),
          buildProfileField('Description', doctor.description),
          buildProfileField('Location', doctor.location.toString()),
          buildProfileField('Latitude', doctor.lat),
          buildProfileField('Longitude', doctor.lng),
        ],
      );
    } else {
      return Container(); // Empty container if the user type and data don't match
    }
  }

  Widget buildProfileField(String label, String? value) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.grey[800],
            ),
          ),
          SizedBox(height: 4),
          Text(
            value ?? '',
            style: TextStyle(
              fontSize: 18,
              color: Colors.grey[600],
            ),
          ),
        ],
      ),
    );
  }
}
