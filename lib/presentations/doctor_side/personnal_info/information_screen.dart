// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:my_daktari/presentations/doctor_side/personnal_info/pages/documents_verfication.dart';
import 'package:my_daktari/presentations/doctor_side/personnal_info/pages/personal_information.dart';
import 'package:my_daktari/presentations/doctor_side/personnal_info/pages/specialty.dart';
import 'package:my_daktari/presentations/doctor_side/personnal_info/widgets/line_widget.dart';

import '../../../constants/routes/route.dart' as route;

class PersonalDetailsScreen extends StatefulWidget {
  const PersonalDetailsScreen({Key? key}) : super(key: key);

  @override
  State<PersonalDetailsScreen> createState() => _PersonalDetailsScreenState();
}

class _PersonalDetailsScreenState extends State<PersonalDetailsScreen> {
  int _selectedIndex = 0;

  final pages = [const Personal(), const Specialty(), const DocumentUpload()];

  @override
  Widget build(BuildContext context) {
    print(_selectedIndex);
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () => setState(() {
            if (_selectedIndex > 0) {
              _selectedIndex -= 1;
            } else if (_selectedIndex == 0) {
              Navigator.pop(context);
            }
          }),
          child: Icon(Icons.arrow_back),
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            LineWidget(active: _selectedIndex == 0),
            LineWidget(active: _selectedIndex == 1),
            LineWidget(active: _selectedIndex == 2),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                _selectedIndex == 2 ? 'Verification' : 'Personal Information',
                style:
                    const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                  'Connect with Medical Professionals Anytime, Anywhere',
                  style: TextStyle(fontSize: 16, color: Colors.grey),
                  textAlign: TextAlign.center),
            ),
            const SizedBox(height: 20),
            Container(child: pages[_selectedIndex]),
            const SizedBox(height: 30),
            SizedBox(
              width: 0.8 * MediaQuery.of(context).size.width,
              child: ElevatedButton(
                onPressed: () {
                  setState(() {
                    if (_selectedIndex + 1 < pages.length) {
                      _selectedIndex += 1;
                    } else {
                      Navigator.pushNamed(context, route.homePage);
                    }
                  });
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xff0154ba),
                  padding: const EdgeInsets.all(14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: Text(
                  _selectedIndex == 2 ? 'Save' : 'Continue',
                  style: const TextStyle(color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
