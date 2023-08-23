import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_daktari/logic/bloc/shared_bloc/make_order/make_order_bloc.dart';
import 'package:my_daktari/logic/cubit/order_data/order_data_cubit.dart';
import 'package:my_daktari/presentations/shared_ui/shop/payment/order_price_widget.dart';
import 'package:my_daktari/presentations/widgets/success_dialogue.dart';
import '../../../../../constants/route.dart' as route;

import '../../../../constants/constants.dart';
import '../../../../logic/bloc/shared_bloc/cart/cart_bloc.dart';

class ProductPaymentScreen extends StatelessWidget {
  ProductPaymentScreen({super.key});
  TextEditingController numberController =
      TextEditingController(text: userPhoneNumber);
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(title: const Text('Payment'), elevation: 0),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(children: [
          Container(
              height: 50,
              width: double.infinity,
              margin: EdgeInsets.symmetric(vertical: 20),
              decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(10)),
              child: Image.asset('assets/images/mpesa.png')),
          BlocBuilder<CartBloc, CartState>(
            builder: (context, state) {
              if (state is CartLoaded) {
                return OrderPriceWidget(cartModel: state.cart);
              } else {
                return const SizedBox();
              }
            },
          ),
          SizedBox(height: size.height * .07),
          Align(
              alignment: Alignment.centerLeft,
              child: Text('Enter Phone Number')),
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
                      borderRadius: BorderRadius.circular(10))),
              style: TextStyle(
                  color: Colors.grey,
                  wordSpacing: 2,
                  fontWeight: FontWeight.w600)),
          SizedBox(height: size.height * .05),
          ElevatedButton(
            onPressed: () {
              OrderDataCubit orderDataCubit = context.read<OrderDataCubit>();
              context.read<MakeOrderBloc>().add(
                    PlaceOrder(
                        userID: orderDataCubit.state.userId,
                        totalAmount: orderDataCubit.state.totalAmount,
                        phoneNumber: numberController.text,
                        address: orderDataCubit.state.address,
                        additionalInfo: orderDataCubit.state.additionalInfo,
                        products: orderDataCubit.state.cartItems),
                  );
            },
            style: ElevatedButton.styleFrom(
                minimumSize: Size(size.width, 50),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20))),
            child: BlocConsumer<MakeOrderBloc, MakeOrderState>(
              listener: (context, state) {
                if (state is MakeOrderSuccess) {
                  successDialog(
                      context: context,
                      success: true,
                      message: state.successMessage,
                      route: route.homeScreen,
                      title: 'My Daktari');
                } else if (state is MakeOrderFailure) {
                  successDialog(
                      context: context,
                      success: false,
                      message: state.errorMessage,
                      title: 'My Daktari');
                }
              },
              builder: (context, state) {
                if (state is MakeOrderLoading) {
                  return CupertinoActivityIndicator(color: Colors.white);
                } else {
                  return Text('Pay Now',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold));
                }
              },
            ),
          )
        ]),
      ),
    );
  }
}
