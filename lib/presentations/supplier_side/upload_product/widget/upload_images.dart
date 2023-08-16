import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:my_daktari/logic/cubit/upload_product_data/upload_product_data_cubit.dart';

import '../../../../constants/colors.dart';
import '../../../widgets/scroll_behavior.dart';
import 'select_image_button.dart';

class UploadProductImages extends StatelessWidget {
  const UploadProductImages({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    UploadProductDataCubit uploadDataCubit =
        context.watch<UploadProductDataCubit>();
    Future<void> _pictureImage({required ImageSource source}) async {
      final pickedImage = await ImagePicker().pickImage(source: source);
      if (pickedImage != null) {
        uploadDataCubit.addImageFiles(imageFiles: [File(pickedImage.path)]);
      }
    }

    Future<void> _pickImage() async {
      List<File> selectedImages = [];
      final picker = ImagePicker();
      try {
        final pickedFile = await picker.pickMultiImage(
            imageQuality: 100, maxHeight: 1000, maxWidth: 1000);
        List<XFile> xfilePick = pickedFile;
        if (xfilePick.isNotEmpty) {
          for (var i = 0; i < xfilePick.length; i++) {
            selectedImages.add(File(xfilePick[i].path));
          }
          uploadDataCubit.addImageFiles(imageFiles: selectedImages);
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Nothing is selected')));
        }
      } catch (e) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(e.toString())));
      }
    }

    return Container(
      //height: 200,
      width: double.infinity,
      margin: EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
          color: AppColor.lightGrey, borderRadius: BorderRadius.circular(10)),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text('Product Image (upload Multiple)',
                    style: TextStyle(
                        color: AppColor.blackText,
                        fontWeight: FontWeight.w700,
                        fontSize: 16))),
            BlocBuilder<UploadProductDataCubit, UploadProductDataState>(
              builder: (context, state) {
                return Visibility(
                  visible: state.imageFiles.isNotEmpty,
                  child: SizedBox(
                    height: MediaQuery.of(context).size.height * .2,
                    child: ScrollConfiguration(
                      behavior: MyBehavior(),
                      child: GridView.builder(
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 3, childAspectRatio: 1),
                        itemCount: state.imageFiles.length,
                        itemBuilder: (context, index) {
                          return Container(
                            margin: const EdgeInsets.all(5),
                            height: 120,
                            width: 120,
                            child: Stack(
                              alignment: AlignmentDirectional.center,
                              children: [
                                ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: Image.file(state.imageFiles[index],
                                        fit: BoxFit.cover,
                                        height: 120,
                                        width: 120)),
                                Positioned(
                                  top: 0,
                                  right: 0,
                                  child: GestureDetector(
                                    child: const Icon(
                                        Icons.remove_circle_outlined,
                                        color: Colors.red),
                                    onTap: () =>
                                        uploadDataCubit.removeImageFile(
                                            imageFile: state.imageFiles[index]),
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                );
              },
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 8.0, horizontal: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  UploadButton(
                      title: 'Photo',
                      isCamera: true,
                      onPressed: () =>
                          _pictureImage(source: ImageSource.camera)),
                  UploadButton(
                    title: 'Gallery',
                    onPressed: () => _pickImage(),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
