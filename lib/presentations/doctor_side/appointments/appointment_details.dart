import 'dart:math';

import 'package:flutter/material.dart';
import 'package:my_daktari/constants/constants.dart';
import 'package:my_daktari/models/appointment.dart';

class AppointmentDetailsScreen extends StatelessWidget {
  const AppointmentDetailsScreen({super.key, required this.appointment});
  final AppointmentModel appointment;
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text('Details'),
        elevation: 0,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: size.width * .04),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Card(
            elevation: 0,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25),
                side: BorderSide(color: Colors.black12)),
            child: SizedBox(
              height: 110,
              width: double.infinity,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  children: [
                    Container(
                      margin: EdgeInsets.only(right: size.width * .05),
                      decoration: BoxDecoration(
                          color: Colors.grey,
                          borderRadius: BorderRadius.circular(20)),
                      child: Image.asset('assets/images/male-user.png'),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(appointment.name!,
                            style: TextStyle(
                                color: Colors.black54,
                                fontSize: 21,
                                fontWeight: FontWeight.bold)),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Woman',
                                style: TextStyle(
                                    color: Colors.black54,
                                    fontWeight: FontWeight.w600)),
                            SizedBox(width: 10),
                            Text(', 26 years',
                                style: TextStyle(
                                    color: Colors.black54,
                                    fontWeight: FontWeight.w600)),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(height: size.height * .02),
          Text('Appontment info',
              style: Theme.of(context)
                  .textTheme
                  .displaySmall!
                  .copyWith(fontSize: 20, fontWeight: FontWeight.w800)),
          SizedBox(height: size.height * .02),
          Row(
            children: [
              Container(
                height: 50,
                width: 50,
                margin: EdgeInsets.only(right: size.width * .04),
                decoration: BoxDecoration(
                    color: primaryColor.withOpacity(0.3),
                    borderRadius: BorderRadius.circular(10)),
                child: Icon(Icons.watch_later, color: primaryColor, size: 35),
              ),
              Text('3 PM -4PM - August 10, 2020',
                  style: Theme.of(context)
                      .textTheme
                      .headlineMedium!
                      .copyWith(fontSize: 18)),
            ],
          ),
          SizedBox(height: size.height * .02),
          Row(
            children: [
              Container(
                margin: EdgeInsets.only(right: size.width * .04),
                height: 50,
                width: 50,
                decoration: BoxDecoration(
                    color: Colors.grey.withOpacity(0.3),
                    borderRadius: BorderRadius.circular(10)),
                child: Transform.rotate(
                  angle: 90 * pi / 180,
                  child: Icon(Icons.local_offer_rounded,
                      color: Colors.grey, size: 35),
                ),
              ),
              Text('${appointment.conditions} - Call',
                  style: Theme.of(context)
                      .textTheme
                      .headlineMedium!
                      .copyWith(fontSize: 18)),
            ],
          ),
          SizedBox(height: size.height * .02),
          Text(
            'Patient Notes',
            style: Theme.of(context)
                .textTheme
                .displaySmall!
                .copyWith(fontSize: 20, fontWeight: FontWeight.w800),
          ),
          SizedBox(height: size.height * .02),
          Text(
              'I feel like i have a toothache every time i drink or eat something hot. it all started about a week ago the pain is not severe, but it bothers me',
              style: Theme.of(context)
                  .textTheme
                  .headlineMedium!
                  .copyWith(fontSize: 18)),
          SizedBox(height: size.height * .02),
          Text(
            'Symptoms',
            style: Theme.of(context)
                .textTheme
                .displaySmall!
                .copyWith(fontSize: 20, fontWeight: FontWeight.w800),
          ),
          SizedBox(height: size.height * .02),
          Row(
            children: [
              Container(
                height: 40,
                width: size.width * .3,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.black26),
                ),
                child: Text('Toothache',
                    style: Theme.of(context)
                        .textTheme
                        .headlineMedium!
                        .copyWith(fontSize: 14)),
              ),
              SizedBox(width: 20),
              Container(
                height: 40,
                width: size.width * .3,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.black26),
                ),
                child: Text('Pain after hot',
                    style: Theme.of(context)
                        .textTheme
                        .headlineMedium!
                        .copyWith(fontSize: 14)),
              ),
            ],
          ),
          SizedBox(height: size.height * .02),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                    fixedSize: Size(150, 45), backgroundColor: primaryColor),
                child: Text('Reschedule'),
              ),
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                    fixedSize: Size(150, 45), backgroundColor: greenish),
                child: Text('Decline'),
              )
            ],
          )
        ]),
      ),
    );
  }
}
