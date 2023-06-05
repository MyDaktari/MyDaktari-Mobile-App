import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../../../../logic/cubit/file_name/file_name_cubit.dart';
import '../../../../logic/cubit/infor_page_update/info_page_update_cubit.dart';
import '../../../../constants/routes/route.dart' as route;
import '../../../widgets/success_dialogue.dart';
import '../widgets/upload_container.dart';

import 'package:file_picker/file_picker.dart';

class DocumentUpload extends StatelessWidget {
  DocumentUpload({Key? key}) : super(key: key);
  PlatformFile file = PlatformFile(name: '', size: 0);

  @override
  Widget build(BuildContext context) {
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
                  FilePickerResult? result = await FilePicker.platform
                      .pickFiles(
                          type: FileType.custom,
                          allowedExtensions: ['pdf', 'doc']);
                  if (result != null) {
                    file = result.files.first;
                    fileNameCubit.setCertificateFileName(fileName: file.name);
                  } else {
                    // User canceled the picker
                    // ignore: use_build_context_synchronously
                    successDialog(
                        context: context,
                        message: 'Coudn\'t upload your document',
                        title: 'Blink Hub');
                  }
                },
                child: UploadContainer(
                    document: 'Upload photo',
                    description: fileNameCubit.state.certificate),
              ),
              SizedBox(height: 30),
              GestureDetector(
                  onTap: () async {
                    FilePickerResult? result = await FilePicker.platform
                        .pickFiles(
                            type: FileType.custom,
                            allowedExtensions: ['pdf', 'doc']);
                    if (result != null) {
                      file = result.files.first;
                      fileNameCubit.setNationIdFileName(fileName: file.name);
                    } else {
                      // User canceled the picker
                      // ignore: use_build_context_synchronously
                      successDialog(
                          context: context,
                          message: 'Coudn\'t upload your document',
                          title: 'MyDaktari');
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
                      Navigator.pushNamed(context, route.homePage);
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
                  child: Text(
                    pageCubit.state.index == 2 ? 'Save' : 'Continue',
                    style: const TextStyle(color: Colors.white),
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
