import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_daktari/presentations/widgets/custom_loading.dart';
import 'package:my_daktari/presentations/client_side/homeTab/views/pharmacy/pharmacy_card.dart';

import '../../../../../logic/bloc/pharmacy/pharmacy_bloc.dart';

class PharmacyScreen extends StatelessWidget {
  const PharmacyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Pharmacy')),
      body: BlocBuilder<PharmacyBloc, PharmacyState>(
        builder: (context, state) {
          if (state is PharmacyLoaded) {
            return RefreshIndicator(
              onRefresh: () async =>
                  context.read<PharmacyBloc>().add(LoadPharmacy()),
              child: ListView.builder(
                itemCount: state.pharmacyList.length,
                itemBuilder: (context, index) {
                  return PharmacyCard(
                      pharmacy: state.pharmacyList.elementAt(index));
                },
              ),
            );
          } else if (state is PharmacyLoading) {
            return Center(child: CustomLoading());
          } else {
            return Text('Something went Wrong');
          }
        },
      ),
    );
  }
}
