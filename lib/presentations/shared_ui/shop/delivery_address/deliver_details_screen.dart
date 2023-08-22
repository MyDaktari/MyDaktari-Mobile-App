import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:my_daktari/constants/enums.dart';
import 'package:my_daktari/logic/cubit/order_data/order_data_cubit.dart';
import 'package:my_daktari/logic/cubit/user_type/user_type_cubit.dart';
import 'package:my_daktari/presentations/shared_ui/shop/payment/order_price_widget.dart';
import '../../../../../constants/route.dart' as route;

import '../../../../constants/constants.dart';
import '../../../../logic/bloc/shared_bloc/cart/cart_bloc.dart';

class DeliveryAddressScreen extends StatelessWidget {
  const DeliveryAddressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    UserType userType = context.read<UserTypeCubit>().state.userType;
    String name = '';
    String phone = '';
    String userId = '';
    if (userType == UserType.client) {
      name = client.name.toString();
      phone = client.phone.toString();
      userId = client.id.toString();
    } else if (userType == UserType.doctor) {
      name = doctor.name.toString();
      phone = doctor.phone.toString();
      userId = doctor.id.toString();
    }

    TextEditingController _nameController = TextEditingController(text: name);
    TextEditingController _phoneController = TextEditingController(text: phone);
    TextEditingController _addressController = TextEditingController();
    TextEditingController _additionalInfoController = TextEditingController();
    return Scaffold(
      appBar: AppBar(title: const Text('Delivery Address'), elevation: 0),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              TextField(
                controller: _nameController,
                keyboardType: TextInputType.name,
                decoration: InputDecoration(
                  hintText: 'Name',
                  border: OutlineInputBorder(
                      borderSide:
                          const BorderSide(color: Colors.grey, width: 2)),
                ),
              ),
              SizedBox(height: 16),
              TextField(
                controller: _phoneController,
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(
                  hintText: 'Phone Number',
                  border: OutlineInputBorder(
                      borderSide:
                          const BorderSide(color: Colors.grey, width: 2)),
                ),
              ),
              SizedBox(height: 16),
              TextField(
                controller: _addressController,
                keyboardType: TextInputType.streetAddress,
                decoration: InputDecoration(
                  hintText: 'Address',
                  border: OutlineInputBorder(
                      borderSide:
                          const BorderSide(color: Colors.grey, width: 2)),
                ),
              ),
              SizedBox(height: 16),
              TextField(
                controller: _additionalInfoController,
                decoration: InputDecoration(
                  hintText: 'Apartment, suite, etc. (optional)',
                  border: OutlineInputBorder(
                      borderSide:
                          const BorderSide(color: Colors.grey, width: 2)),
                ),
              ),
              SizedBox(height: 50),
              BlocBuilder<CartBloc, CartState>(
                builder: (context, state) {
                  if (state is CartLoaded) {
                    return OrderPriceWidget(cartModel: state.cart);
                  } else {
                    return const SizedBox();
                  }
                },
              ),
              SizedBox(height: 16),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    minimumSize: const Size(double.infinity, 50),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20))),
                onPressed: () {
                  if (_nameController.text.isNotEmpty &&
                      _phoneController.text.isNotEmpty &&
                      _addressController.text.isNotEmpty &&
                      userId.isNotEmpty) {
                    context.read<OrderDataCubit>().updateOrderData(
                        userId: userId,
                        name: _nameController.text,
                        phone: _phoneController.text,
                        address: _addressController.text,
                        additionalInfo: _additionalInfoController.text);
                    Navigator.of(context).pushNamed(route.productPaymentScreen);
                  } else {
                    Fluttertoast.showToast(msg: 'Please fill all fields');
                  }
                },
                child: const Text('CONFIRM',
                    style: TextStyle(fontWeight: FontWeight.bold)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
