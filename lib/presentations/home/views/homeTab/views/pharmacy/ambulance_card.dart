import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:my_daktari/constants/constants.dart';
import 'package:my_daktari/models/ambulance.dart';

class AmbulanceCard extends StatelessWidget {
  const AmbulanceCard({super.key, required this.ambulance});
  final AmbulanceModel ambulance;

  @override
  Widget build(BuildContext context) {
    _callNumber() async {
      final number = ambulance.ambulancePhone; //set the number here
      await FlutterPhoneDirectCaller.callNumber(number.toString());
    }

    Size size = MediaQuery.of(context).size;
    return Container(
      width: size.width,
      height: size.height * .15,
      child: Center(
        child: Card(
          margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.local_hospital, size: 70, color: primaryColor),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(ambulance.ambulanceName.toString(),
                            style: Theme.of(context)
                                .textTheme
                                .headlineSmall!
                                .copyWith(
                                    fontSize: 15, fontWeight: FontWeight.w600)),
                        Text(ambulance.ambulanceEmail.toString(),
                            style: Theme.of(context)
                                .textTheme
                                .headlineSmall!
                                .copyWith(fontSize: 12)),
                        Text(ambulance.ambulanceLocation.toString()),
                      ],
                    ),
                  ],
                ),
                InkWell(
                  onTap: _callNumber,
                  child: CircleAvatar(
                    minRadius: 30,
                    backgroundColor: primaryColor,
                    child: Icon(Icons.call, size: 40, color: Colors.white),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
