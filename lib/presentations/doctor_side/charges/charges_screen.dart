import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:my_daktari/constants/constants.dart';
import 'package:my_daktari/logic/bloc/shared_bloc/auth_status/auth_status_bloc.dart';
import 'package:my_daktari/logic/bloc/doctor_bloc/doctor_charges/doctor_charges_bloc.dart';
import 'package:my_daktari/presentations/doctor_side/charges/charge_card.dart';
import 'package:my_daktari/presentations/widgets/success_dialogue.dart';
import 'package:my_daktari/constants/route.dart' as route;
import 'package:my_daktari/repositories/shared_repositories/authentication/authentication_repository.dart';

class ChargesScreen extends StatelessWidget {
  ChargesScreen({super.key});

  final TextEditingController chatCotroller = TextEditingController();
  final TextEditingController phoneCotroller = TextEditingController();
  final TextEditingController videoCotroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    AuthenticationRepository authRepository = AuthenticationRepository();
    return Scaffold(
      appBar: AppBar(
          title: const Text("Set Your Fees",
              style: TextStyle(fontWeight: FontWeight.bold)),
          centerTitle: true),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0),
                child: Text(
                    'Connect with Medical Professionals Anytime, Anywhere',
                    style: TextStyle(fontSize: 16, color: Colors.black),
                    textAlign: TextAlign.center),
              ),
              const SizedBox(height: 20),
              ChargeWidget(title: 'Chat', controller: chatCotroller),
              const SizedBox(height: 30),
              ChargeWidget(title: 'Phone Call', controller: phoneCotroller),
              const SizedBox(height: 30),
              ChargeWidget(title: 'Video Call', controller: videoCotroller),
              const SizedBox(height: 30),
              Align(
                alignment: Alignment.center,
                child: SizedBox(
                  width: 0.9 * MediaQuery.of(context).size.width,
                  child: ElevatedButton(
                      onPressed: () {
                        if (chatCotroller.text.isNotEmpty &&
                            phoneCotroller.text.isNotEmpty &&
                            videoCotroller.text.isNotEmpty) {
                          context
                              .read<DoctorChargesBloc>()
                              .add(SetDoctorCharges(
                                doctorId: userId,
                                chatCost: chatCotroller.text.trim(),
                                phoneCallCost: phoneCotroller.text.trim(),
                                videoCallCost: videoCotroller.text.trim(),
                              ));
                        } else {
                          Fluttertoast.showToast(msg: 'All field Required!');
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
                          BlocConsumer<DoctorChargesBloc, DoctorChargesState>(
                        listener: (context, state) {
                          if (state is DoctorChargesLoaded) {
                            authRepository.updateUserProfile(fullProfile: true);
                            context
                                .read<AuthStatusBloc>()
                                .add(CheckUserStatus());
                            successDialog(
                                success: true,
                                context: context,
                                route: route.homeScreen,
                                message: 'Successfully Saved !',
                                title: 'My Daktari');
                          }
                          if (state is DoctorChargesLoadError) {
                            successDialog(
                                context: context,
                                message: state.message,
                                title: 'My Daktari');
                          }
                        },
                        builder: (context, state) {
                          if (state is DoctorChargesLoading) {
                            return CupertinoActivityIndicator(
                                color: Colors.white);
                          } else {
                            return Text('Save',
                                style: TextStyle(color: Colors.white));
                          }
                        },
                      )),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
