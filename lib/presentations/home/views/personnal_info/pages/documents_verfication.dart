import 'package:flutter/material.dart';

import '../../../../doctor_side/personnal_info/widgets/upload_container.dart';

class DocumentUpload extends StatelessWidget {
  const DocumentUpload({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              UploadContainer(
                  document: 'Upload photo',
                  description:
                      'Lorem ipsum dolor sit amet, consecateur adespuse elit'),
              SizedBox(
                height: 30,
              ),
              UploadContainer(
                  document: 'Upload a copy of your national ID',
                  description:
                      'Lorem ipsum dolor sit amet, consecateur adespuse elit'),
              SizedBox(
                height: 30,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
