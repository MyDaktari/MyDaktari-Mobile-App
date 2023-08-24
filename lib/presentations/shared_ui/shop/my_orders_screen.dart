import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_daktari/constants/colors.dart';
import 'package:my_daktari/constants/constants.dart';
import 'package:my_daktari/logic/cubit/user_type/user_type_cubit.dart';
import 'package:my_daktari/presentations/widgets/custom_loading.dart';

import '../../../constants/enums.dart';
import '../../../logic/bloc/shared_bloc/load_orders/load_order_bloc.dart';
import 'widgets/order_Item.dart';

class MyOrdersScreen extends StatelessWidget {
  const MyOrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('My Orders')),
      body: Container(
        margin: const EdgeInsets.all(10),
        decoration: BoxDecoration(
            border: Border.all(color: AppColor.bankground),
            borderRadius: BorderRadius.circular(10)),
        child: BlocBuilder<UserTypeCubit, UserTypeState>(
          builder: (context, state) {
            String userId = state.userType == UserType.client
                ? client.id.toString()
                : doctor.id.toString();
            return BlocBuilder<OrderBloc, OrderState>(
              builder: (context, state) {
                if (state is OrdersLoading) {
                  return const Center(child: CustomLoading());
                } else if (state is OrdersLoadinFailed) {
                  return Center(
                      child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(state.message.toString()),
                      TextButton(
                          onPressed: () => context
                              .read<OrderBloc>()
                              .add(LoadOrders(userId: userId)),
                          child: const Text('Retry'))
                    ],
                  ));
                } else if (state is OrderLoadSuccess) {
                  return ListView.builder(
                    itemCount: state.orders.length, // Number of orders
                    itemBuilder: (context, index) {
                      return OrderItem();
                    },
                  );
                } else {
                  return Center(
                      child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('We could not load your orders'),
                      TextButton(
                          onPressed: () => context
                              .read<OrderBloc>()
                              .add(LoadOrders(userId: userId)),
                          child: const Text('Retry'))
                    ],
                  ));
                }
              },
            );
          },
        ),
      ),
    );
  }
}
