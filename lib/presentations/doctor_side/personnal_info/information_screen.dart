// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_daktari/presentations/doctor_side/personnal_info/pages/documents_verfication.dart';
import 'package:my_daktari/presentations/doctor_side/personnal_info/pages/personal_information.dart';
import 'package:my_daktari/presentations/doctor_side/personnal_info/pages/specialty.dart';
import 'package:my_daktari/presentations/doctor_side/personnal_info/widgets/line_widget.dart';
import 'package:my_daktari/presentations/shared_ui/profileTab/widgets/log_out_dialog.dart';

import '../../../logic/cubit/infor_page_update/info_page_update_cubit.dart';

class PersonalDetailsScreen extends StatelessWidget {
  PersonalDetailsScreen({Key? key}) : super(key: key);

  final pages = [Personal(), Specialty(), DocumentUpload()];

  @override
  Widget build(BuildContext context) {
    final pageCubit = context.watch<InfoPageUpdateCubit>();

    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () {
            if (pageCubit.state.index > 0) {
              pageCubit.setPageIndex(pageCubit.state.index - 1);
            } else {
              logOutDialog(context);
            }
          },
          child: Visibility(
            visible: pageCubit.state.index != 0,
            child: Icon(Icons.arrow_back),
          ),
        ),
        leadingWidth: pageCubit.state.index != 0 ? 56 : 0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            LineWidget(active: pageCubit.state.index == 0),
            LineWidget(active: pageCubit.state.index == 1),
            LineWidget(active: pageCubit.state.index == 2),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                pageCubit.state == 2 ? 'Verification' : 'Personal Information',
                style:
                    const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                'Connect with Medical Professionals Anytime, Anywhere',
                style: TextStyle(fontSize: 16, color: Colors.grey),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 20),
            Container(child: pages[pageCubit.state.index]),
          ],
        ),
      ),
    );
  }
}
