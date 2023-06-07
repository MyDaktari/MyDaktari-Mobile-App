// ignore_for_file: must_be_immutable

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:my_daktari/constants/constants.dart';
import 'package:my_daktari/logic/bloc/doctor_bloc/complete_profile/complete_profile_bloc.dart';
import 'package:my_daktari/repositories/authentication/authentication_repository.dart';
import '../../../../logic/cubit/file_name/file_name_cubit.dart';
import '../../../../logic/cubit/infor_page_update/info_page_update_cubit.dart';
import '../../../../constants/routes/route.dart' as route;
import '../../../../logic/cubit/personal_info/personal_info_cubit.dart';
import '../../../widgets/success_dialogue.dart';
import '../widgets/upload_container.dart';

import 'package:file_picker/file_picker.dart';

class DocumentUpload extends StatelessWidget {
  DocumentUpload({Key? key}) : super(key: key);
  PlatformFile file = PlatformFile(name: '', size: 0);

  @override
  Widget build(BuildContext context) {
    AuthenticationRepository authRepository = AuthenticationRepository();
    final personalInfo = context.watch<PersonalInfoCubit>();
    final fileNameCubit = context.watch<FileNameCubit>();
    final pageCubit = context.watch<InfoPageUpdateCubit>();
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              GestureDetector(
                onTap: () async {
                  FilePickerResult? result =
                      await FilePicker.platform.pickFiles(
                          // type: FileType.custom,
                          // allowedExtensions: ['pdf', 'doc'],
                          );
                  if (result != null) {
                    file = result.files.first;
                    fileNameCubit.setCertificateFileName(fileName: file.name);
                    personalInfo.updatePersonalFile(profilePicture: file);
                  } else {
                    // User canceled the picker
                    // ignore: use_build_context_synchronously
                    successDialog(
                        context: context,
                        message: 'Coudn\'t upload your document',
                        title: 'My Daktari');
                  }
                },
                child: UploadContainer(
                    document: 'Upload photo',
                    description: fileNameCubit.state.certificate),
              ),
              SizedBox(height: 30),
              GestureDetector(
                  onTap: () async {
                    FilePickerResult? result =
                        await FilePicker.platform.pickFiles(
                            // type: FileType.custom,
                            // allowedExtensions: ['pdf', 'doc'],
                            );
                    if (result != null) {
                      file = result.files.first;
                      fileNameCubit.setNationIdFileName(fileName: file.name);
                      personalInfo.updatePersonalFile(nationalId: file);
                    } else {
                      // User canceled the picker
                      // ignore: use_build_context_synchronously
                      successDialog(
                          context: context,
                          message: 'Coudn\'t upload your document',
                          title: 'My Daktari');
                    }
                  },
                  child: UploadContainer(
                      document: 'Upload a copy of your national ID',
                      description: fileNameCubit.state.nationalId)),
              SizedBox(height: 30),
              const SizedBox(height: 30),
              SizedBox(
                width: 0.8 * MediaQuery.of(context).size.width,
                child: ElevatedButton(
                  onPressed: () {
                    if (fileNameCubit.state.certificate.isNotEmpty &&
                        fileNameCubit.state.nationalId.isNotEmpty) {
                      context
                          .read<CompleteProfileBloc>()
                          .add(DoctorUpdateProfile(
                            doctorId: userId,
                            title: personalInfo.state.title,
                            specialty: personalInfo.state.specialty,
                            experience: personalInfo.state.experience,
                            careerOverview: personalInfo.state.careerOverview,
                            location: personalInfo.state.location,
                            nationalId: personalInfo.state.nationalId,
                            profilePicture: personalInfo.state.profilePicture,
                          ));
                    } else {
                      Fluttertoast.showToast(msg: 'Kindly upload both files');
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
                      BlocConsumer<CompleteProfileBloc, CompleteProfileState>(
                    listener: (context, state) {
                      if (state is CompleteProfileLoadError) {
                        successDialog(
                            context: context,
                            message: state.message,
                            title: 'My Daktari');
                      }
                      if (state is CompleteProfileLoaded) {
                        authRepository.updateUserProfile();
                        Navigator.pushNamed(context, route.homeScreen);
                      }
                    },
                    builder: (context, state) {
                      return state is CompleteProfileLoading
                          ? CupertinoActivityIndicator(color: Colors.white)
                          : Text(
                              pageCubit.state.index == 2 ? 'Save' : 'Continue',
                              style: const TextStyle(color: Colors.white));
                    },
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
