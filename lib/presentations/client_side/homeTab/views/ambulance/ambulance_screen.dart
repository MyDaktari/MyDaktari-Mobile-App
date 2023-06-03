import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_daktari/presentations/widgets/custom_loading.dart';
import 'package:my_daktari/presentations/client_side/homeTab/views/ambulance/ambulance_card.dart';

import '../../../../../logic/bloc/ambulance/ambulance_bloc.dart';

class AmbulanceScreen extends StatelessWidget {
  const AmbulanceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Call an Ambulance')),
      body: BlocBuilder<AmbulanceBloc, AmbulanceState>(
        builder: (context, state) {
          if (state is AmbulanceLoaded) {
            return RefreshIndicator(
              onRefresh: () async =>
                  context.read<AmbulanceBloc>().add(LoadAmbulances()),
              child: ListView.builder(
                itemCount: state.ambulances.length,
                itemBuilder: (context, index) {
                  return AmbulanceCard(
                      ambulance: state.ambulances.elementAt(index));
                },
              ),
            );
          } else if (state is AmbulanceLoading) {
            return Center(child: CustomLoading());
          } else {
            return Text('Something went Wrong');
          }
        },
      ),
    );
  }
}
