// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:my_daktari/presentations/doctor_side/schedule/widgets/schedule_screen_body.dart';

class ScheduleScreen extends StatelessWidget {
  const ScheduleScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text("Manage Appointments",
              style: TextStyle(fontWeight: FontWeight.bold)),
          centerTitle: true),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0),
                child: Text(
                    'Connect with Medical Professionals Anytime, Anywhere',
                    style: TextStyle(fontSize: 16, color: Colors.black),
                    textAlign: TextAlign.center),
              ),
              const SizedBox(height: 20),
              const ScheduleTimes(),
              const SizedBox(height: 30),
              Align(
                alignment: Alignment.center,
                child: SizedBox(
                  width: 0.9 * MediaQuery.of(context).size.width,
                  child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xff0154ba),
                        padding: const EdgeInsets.all(14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: const Text('Save',
                          style: TextStyle(color: Colors.white))),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
