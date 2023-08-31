import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_daktari/constants/colors.dart';
import 'package:my_daktari/constants/constants.dart';
import '../../../../../../constants/route.dart' as route;
import '../../../../../../logic/bloc/shared_bloc/blood_sugar/blood_sugar_bloc.dart';
import '../widget/blood_summary_tile.dart';
import 'graph/blood_graph.dart';

class BoodSugarScreen extends StatelessWidget {
  BoodSugarScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Blood Sugar Readings',
            style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
                color: AppColor.primaryColor)),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () =>
                  Navigator.pushNamed(context, route.recordSugarScreen),
              icon: const Icon(Icons.add, size: 28))
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            BloodGraph(),
            BlocBuilder<BloodSugarBloc, BloodSugarState>(
              builder: (context, state) {
                if (state is BloodSugarLoadSuccess) {
                  return Visibility(
                    visible: state.records.isNotEmpty,
                    replacement: Column(
                      children: [
                        Text('No readings yet',
                            style: TextStyle(
                                fontSize: 18.0,
                                fontWeight: FontWeight.bold,
                                color: AppColor.primaryColor)),
                        SizedBox(height: 10.0),
                        Text('Tap the + button to add a reading',
                            style: TextStyle(fontSize: 15)),
                      ],
                    ),
                    child: Column(
                      children: [
                        SizedBox(height: 10.0),
                        SizedBox(height: 10.0),
                        BloodSummaryTile(
                            label: 'Average', value: state.average.toString()),
                        BloodSummaryTile(
                            label: 'Highest', value: state.highest.toString()),
                        BloodSummaryTile(
                            label: 'Lowest', value: state.lowest.toString()),
                        SizedBox(height: 10.0),
                        Text('Tap the + button to add a reading',
                            style: TextStyle(fontSize: 15)),
                      ],
                    ),
                  );
                } else if (state is BloodSugarsLoadinFailed) {
                  return Center(
                    child: Column(
                      children: [
                        Text(state.message),
                        const SizedBox(height: 10.0),
                        ElevatedButton(
                          onPressed: () {
                            context
                                .read<BloodSugarBloc>()
                                .add(LoadBloodSugarRecord(userId: userId));
                          },
                          child: const Text('Retry'),
                        ),
                      ],
                    ),
                  );
                }
                return Container();
              },
            ),
            SizedBox(height: 10.0),
          ],
        ),
      ),
      floatingActionButtonAnimator: FloatingActionButtonAnimator.scaling,
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.pushNamed(context, route.recordSugarScreen),
        backgroundColor: AppColor.lightGreen,
        child: const Icon(Icons.add, size: 28),
      ),
    );
  }
}
