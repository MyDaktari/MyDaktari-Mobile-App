// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:my_daktari/logic/cubit/personal_info/personal_info_cubit.dart';

import '../../../../logic/cubit/infor_page_update/info_page_update_cubit.dart';
import '../widgets/text_field.dart';

class Specialty extends StatelessWidget {
  Specialty({Key? key}) : super(key: key);
  TextEditingController specialtyController = TextEditingController();
  TextEditingController expController = TextEditingController();
  TextEditingController locationController = TextEditingController();
  TextEditingController careerController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final pageCubit = context.watch<InfoPageUpdateCubit>();
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: TextWidget(
                  label: 'Specialty', controller: specialtyController)),
          SizedBox(height: 16),
          Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: TextWidget(
                  isNumber: true,
                  label: 'Experience in years',
                  controller: expController)),
          SizedBox(height: 16),
          Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: TextWidget(
                  label: 'Location', controller: locationController)),
          SizedBox(height: 16),
          Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: TextWidget(
                  label: 'Career Overview',
                  maxLines: 4,
                  controller: careerController)),
          SizedBox(height: 16),
          const SizedBox(height: 30),
          SizedBox(
            width: 0.8 * MediaQuery.of(context).size.width,
            child: ElevatedButton(
              onPressed: () {
                if (specialtyController.text.isNotEmpty &&
                    locationController.text.isNotEmpty &&
                    careerController.text.isNotEmpty &&
                    expController.text.isNotEmpty) {
                  context.read<PersonalInfoCubit>().updatePersonalInfo(
                      specialty: specialtyController.text,
                      careerOverview: careerController.text,
                      location: locationController.text,
                      experience: int.parse(expController.text));
                  if (pageCubit.state.index + 1 < pageCubit.state.pagesNumber) {
                    pageCubit.setPageIndex(pageCubit.state.index + 1);
                  }
                } else {
                  Fluttertoast.showToast(msg: 'All fields required');
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xff0154ba),
                padding: const EdgeInsets.all(14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child:
                  Text('Continue', style: const TextStyle(color: Colors.white)),
            ),
          ),
        ],
      ),
    );
  }
}
