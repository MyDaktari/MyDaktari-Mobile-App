import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_daktari/presentations/widgets/custom_loading.dart';
import '../../../../../../constants/constants.dart';
import '../../../../../../constants/route.dart' as route;
import 'package:my_daktari/constants/colors.dart';

import '../../../../../../logic/bloc/shared_bloc/medication/medication_bloc.dart';
import 'medication_record.dart';

class MedicationScreen extends StatelessWidget {
  const MedicationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Medication'),
        ),
        body: BlocBuilder<MedicationBloc, MedicationState>(
          builder: (context, state) {
            if (state is MedicationLoading) {
              return Center(child: CustomLoading());
            } else if (state is MedicationLoadSuccess) {
              return Visibility(
                visible: state.records.isNotEmpty,
                replacement: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('No Medication Record'),
                      TextButton(
                          onPressed: () => Navigator.pushNamed(
                              context, route.recordMedicationScreen),
                          child: Text('Add Record')),
                    ],
                  ),
                ),
                child: ListView.builder(
                  itemCount: state.records.length,
                  itemBuilder: (context, index) {
                    return MedicationRecord(
                      medicationModel: state.records[index],
                    );
                  },
                ),
              );
            } else if (state is MedicationsLoadinFailed) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(state.message),
                    TextButton(
                        onPressed: () => context
                            .read<MedicationBloc>()
                            .add(LoadMedicationRecord(userId: userId)),
                        child: Text('Retry')),
                  ],
                ),
              );
            } else {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('No Medication Record'),
                    TextButton(
                        onPressed: () => context
                            .read<MedicationBloc>()
                            .add(LoadMedicationRecord(userId: userId)),
                        child: Text('Retry')),
                  ],
                ),
              );
            }
          },
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: AppColor.lightGreen,
          onPressed: () =>
              Navigator.pushNamed(context, route.recordMedicationScreen),
          child: Icon(Icons.add),
        ));
  }
}
