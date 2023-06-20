// ignore_for_file: must_be_immutable

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_daktari/constants/constants.dart';
import 'package:my_daktari/logic/bloc/client_bloc/payment/payment_bloc.dart';
import 'package:my_daktari/logic/cubit/booking_info/booking_info_cubit.dart';
import 'package:my_daktari/presentations/widgets/success_dialogue.dart';

class PaymentScreen extends StatelessWidget {
  PaymentScreen({super.key});
  TextEditingController numberController =
      TextEditingController(text: userPhoneNumber);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar:
          AppBar(title: Text('Make payment'), centerTitle: true, elevation: 0),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 20),
          child: BlocBuilder<BookingInfoCubit, BookingInfoState>(
            builder: (context, appState) {
              return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                        height: 50,
                        width: double.infinity,
                        margin: EdgeInsets.symmetric(vertical: 20),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10)),
                        child: Image.asset('assets/images/mpesa.png')),
                    Text(
                      'Summary',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: size.height * .01),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Subtotal'),
                          Text('Ksh ${appState.amount}')
                        ]),
                    SizedBox(height: size.height * .01),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [Text('Discount'), Text('Ksh 0')]),
                    SizedBox(height: size.height * .01),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [Text('Tax'), Text('Ksh 00')]),
                    SizedBox(height: size.height * .01),
                    Divider(height: 2),
                    SizedBox(height: size.height * .015),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Grand Total',
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 18,
                                fontWeight: FontWeight.bold)),
                        Text('Ksh ${appState.amount}',
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 18,
                                fontWeight: FontWeight.bold))
                      ],
                    ),
                    SizedBox(height: size.height * .07),
                    Text('Enter Phone Number'),
                    SizedBox(height: size.height * .02),
                    TextField(
                      controller: numberController,
                      enableSuggestions: false,
                      autocorrect: false,
                      keyboardType: TextInputType.phone,
                      maxLengthEnforcement: MaxLengthEnforcement.enforced,
                      maxLength: 10, // Set the maximum length to 10 characters
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)),
                      ),
                      style: TextStyle(
                          color: Colors.grey,
                          wordSpacing: 2,
                          fontWeight: FontWeight.w600),
                    ),
                    SizedBox(height: size.height * .07),
                    Center(
                      child: ElevatedButton(
                          onPressed: () {
                            context.read<PaymentBloc>().add(MakePayment(
                                amount: appState.amount,
                                appointmentID: appState.appointmentId,
                                userPhoneNumber: numberController.text));
                          },
                          style: ElevatedButton.styleFrom(
                              backgroundColor: primaryColor,
                              fixedSize: Size(size.width * .8, 55)),
                          child: BlocConsumer<PaymentBloc, PaymentState>(
                            listener: (context, state) {
                              if (state is PaymentSuccess) {
                                successDialog(
                                    context: context,
                                    message: state.successMessage,
                                    success: true,
                                    title: 'My Daktari');
                              }
                            },
                            builder: (context, state) {
                              return state is PaymentLoading
                                  ? CupertinoActivityIndicator(
                                      color: Colors.white)
                                  : Text('Pay Now');
                            },
                          )),
                    )
                  ]);
            },
          ),
        ),
      ),
    );
  }
}
