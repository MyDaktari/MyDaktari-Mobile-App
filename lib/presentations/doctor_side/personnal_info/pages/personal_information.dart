// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_daktari/constants/constants.dart';
import '../../../../logic/cubit/infor_page_update/info_page_update_cubit.dart';

import '../widgets/text_field.dart';

class Personal extends StatelessWidget {
  Personal({Key? key}) : super(key: key);
  TextEditingController nameController = TextEditingController();
  TextEditingController genderController = TextEditingController();
  TextEditingController dobController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final pageCubit = context.watch<InfoPageUpdateCubit>();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            child: TextWidget(
              isConst: true,
              label: doctor.name.toString(),
              controller: nameController,
            )),
        SizedBox(height: 16),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0),
          child: Row(
            children: [
              Expanded(
                child: TextWidget(
                    isConst: true,
                    label: 'Gender: ${doctor.gender}',
                    controller: genderController),
              ),
              SizedBox(width: 16),
              Expanded(
                  child: TextWidget(
                      isConst: true,
                      label: 'DoB: ${doctor.dob}',
                      controller: dobController)),
            ],
          ),
        ),
        SizedBox(height: 16),
        Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            child: TextWidget(
                isConst: true,
                label: 'Email: ${doctor.email}',
                controller: emailController)),
        SizedBox(height: 16),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0),
          child: TextWidget(
              isConst: true,
              label: 'Phone Number: ${doctor.phone}',
              controller: phoneController),
        ),
        const SizedBox(height: 30),
        SizedBox(
          width: 0.8 * MediaQuery.of(context).size.width,
          child: ElevatedButton(
            onPressed: () {
              if (pageCubit.state.index + 1 < pageCubit.state.pagesNumber) {
                pageCubit.setPageIndex(pageCubit.state.index + 1);
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xff0154ba),
              padding: const EdgeInsets.all(14),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
            ),
            child:
                Text('Continue', style: const TextStyle(color: Colors.white)),
          ),
        ),
      ],
    );
  }
}
