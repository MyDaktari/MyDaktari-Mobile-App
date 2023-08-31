import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_daktari/logic/bloc/shared_bloc/blood_sugar/blood_sugar_bloc.dart';
import '../../../../../../constants/constants.dart';
import '../../../../../../constants/route.dart' as route;
import '../../../../../../constants/colors.dart';

class BloodHomeCard extends StatelessWidget {
  const BloodHomeCard({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<BloodSugarBloc>().add(LoadBloodSugarRecord(userId: userId));
    return GestureDetector(
      onTap: () => Navigator.pushNamed(context, route.bloodGlucoseScreen),
      child: Card(
        child: Container(
          height: 100,
          alignment: Alignment.center,
          padding: EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Row(
                children: [
                  Icon(Icons.water_drop_rounded, color: Colors.red),
                  Text(' Blood glucose',
                      style: TextStyle(
                          fontSize: 18.0, fontWeight: FontWeight.bold))
                ],
              ),
              Row(
                children: [
                  Text('Average: ', style: TextStyle(fontSize: 18)),
                  BlocBuilder<BloodSugarBloc, BloodSugarState>(
                    builder: (context, state) {
                      if (state is BloodSugarLoadSuccess) {
                        return Text(state.average.toStringAsFixed(1),
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: AppColor.primaryColor));
                      } else if (state is BloodSugarLoading) {
                        return CupertinoActivityIndicator(
                            color: AppColor.primaryColor);
                      } else {
                        return Text('0',
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: AppColor.primaryColor));
                      }
                    },
                  ),
                  Text(' mg/dL', style: TextStyle(fontSize: 15)),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
