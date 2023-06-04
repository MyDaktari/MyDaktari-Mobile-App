import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_daktari/constants/enums.dart';
import '../../../logic/bloc/auth_status/auth_status_bloc.dart';
import '../../../logic/cubit/user_type/user_type_cubit.dart';
import '../widgets/log_out_dialog.dart';
import '../widgets/profile_summary.dart';

class ProfileTab extends StatelessWidget {
  ProfileTab({super.key});

  static const List<Map<String, dynamic>> doctorPages = [
    {"schedule": "Schedule"},
    {"appointments": "My Appointments"},
    {"profile": "Basic info"},
    {"articles": "Articles"}
  ];
  static const List<Map<String, dynamic>> patientPages = [
    {"appointments": "My Appointments"},
    {"profile": "Basic info"},
    {"articles": "Articles"}
  ];

  @override
  Widget build(BuildContext context) {
    final userTypeCubit = context.watch<UserTypeCubit>();
    return Column(
      children: [
        ProfileSummary(),
        const SizedBox(height: 20),
        Expanded(
          child: ListView.builder(
            physics: NeverScrollableScrollPhysics(),
            itemCount: userTypeCubit.state.userType == UserType.doctor
                ? doctorPages.length
                : patientPages.length,
            itemBuilder: (context, index) {
              final route = userTypeCubit.state.userType == UserType.doctor
                  ? doctorPages[index].keys.first
                  : patientPages[index].keys.first;
              final title = userTypeCubit.state.userType == UserType.doctor
                  ? doctorPages[index].values.first
                  : patientPages[index].values.first;
              ;
              return Container(
                decoration: BoxDecoration(
                    border: Border(bottom: BorderSide(width: 0.1))),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: ListTile(
                    contentPadding: const EdgeInsets.all(10),
                    leading: CircleAvatar(
                        backgroundColor: Colors.transparent,
                        child: const Icon(Icons.calendar_today_rounded,
                            color: Colors.blue)),
                    title: Text(title,
                        style: const TextStyle(color: Colors.black)),
                    trailing: const Icon(Icons.arrow_forward_ios),
                    onTap: () {
                      // Handle list item tap
                      // You can navigate to the corresponding route using Navigator
                      Navigator.pushNamed(context, route);
                    },
                  ),
                ),
              );
            },
          ),
        ),
        BlocBuilder<AuthStatusBloc, AuthStatusState>(
          builder: (context, state) {
            return Visibility(
              visible: state is UserAuthenticated,
              child: TextButton(
                onPressed: () => logOutDialog(context),
                child: const Text('Logout',
                    style: TextStyle(fontSize: 18, color: Colors.red)),
              ),
            );
          },
        ),
        SizedBox(height: 20)
      ],
    );
  }
}
