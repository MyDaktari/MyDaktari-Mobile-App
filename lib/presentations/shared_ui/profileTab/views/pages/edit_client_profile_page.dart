import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:my_daktari/logic/bloc/client_bloc/update_profile/update_profile_bloc.dart';
import 'package:my_daktari/presentations/shared_ui/profileTab/widgets/custom_profile_tf.dart';
import 'package:my_daktari/presentations/shared_ui/profileTab/widgets/date_picker.dart';
import 'package:my_daktari/presentations/shared_ui/profileTab/widgets/gender_picker.dart';
import '../../../../../constants/enums.dart';
import '../../../../../logic/cubit/profile_page_view/profile_view_cubit.dart';
import '../../../../../logic/cubit/update_profile/update_profile_cubit.dart';
import '../../../../../models/client.dart';
import '../../widgets/modal_bottom_sheet.dart';

class EditClientProfilePage extends StatelessWidget {
  EditClientProfilePage(
      {super.key, required this.userType, required this.client});
  final UserType userType;
  final ClientModel client;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    TextEditingController nameController =
        TextEditingController(text: client.name);
    TextEditingController phoneNumberController =
        TextEditingController(text: client.phone);
    return Column(
      children: [
        Container(
          height: 120,
          width: 130,
          margin: EdgeInsetsDirectional.only(bottom: 10),
          child: Stack(
            alignment: Alignment.center,
            children: [
              Container(
                height: 100,
                width: 100,
                clipBehavior: Clip.antiAlias,
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(10)),
                child: CachedNetworkImage(
                    placeholder: (context, url) {
                      return CupertinoActivityIndicator();
                    },
                    errorWidget: (context, url, error) => const Image(
                        image: AssetImage('assets/images/male-user.png')),
                    fit: BoxFit.cover,
                    imageUrl: client.profileImage.toString()),
              ),
              Positioned(
                bottom: 0,
                right: 0,
                child: InkWell(
                    onTap: () => showModalBottomSheet(
                        context: context,
                        shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.vertical(
                                top: Radius.circular(25.0))),
                        builder: (_) => ModalBottomSheet()),
                    borderRadius: BorderRadius.circular(20),
                    child: CircleAvatar(
                        backgroundColor: Color(0xfff0f3fc),
                        child: Icon(Icons.edit))),
              )
            ],
          ),
        ),
        CustomProfileTextField(
            hintText: 'Full Name', controller: nameController),
        CustomProfileTextField(
            hintText: 'Phone Number', controller: phoneNumberController),
        ProfileDatePicker(date: client.dob.toString()),
        GenderMenu(
            gender: client.gender.toString().toLowerCase() == 'male'
                ? Sex.male
                : Sex.female),
        SizedBox(height: 20),
        ElevatedButton(
          onPressed: () {
            if (nameController.text.isNotEmpty &&
                nameController.text.isNotEmpty &&
                phoneNumberController.text.isNotEmpty &&
                context.read<UpdateProfileCubit>().state.birthDate.isNotEmpty &&
                context.read<UpdateProfileCubit>().state.sex.name.isNotEmpty) {
              context.read<UpdateProfileBloc>().add(UpdateClientProfile(
                  userId: client.id.toString(),
                  name: nameController.text,
                  dob: context.read<UpdateProfileCubit>().state.birthDate,
                  gender: context.read<UpdateProfileCubit>().state.sex.name,
                  phoneNumber: phoneNumberController.text,
                  profilePicture:
                      context.read<UpdateProfileCubit>().state.imagePath));
            } else {
              print('something is empty');
            }
          },
          style: ElevatedButton.styleFrom(fixedSize: Size(size.width * .5, 45)),
          child: BlocConsumer<UpdateProfileBloc, UpdateProfileState>(
            listener: (context, state) {
              if (state is UpdateProfileLoaded) {
                Fluttertoast.showToast(msg: 'Profile Updated!');
                context
                    .read<ProfileViewCubit>()
                    .switchToNextSession(profileIndex: 0);
              }
              if (state is UpdateProfileLoadError) {
                print(state.message);
                print('Not okay');
              }
            },
            builder: (context, state) {
              if (state is UpdateProfileLoading) {
                return CupertinoActivityIndicator(color: Colors.white);
              } else {
                return Text('Save');
              }
            },
          ),
        )
      ],
    );
  }
}
