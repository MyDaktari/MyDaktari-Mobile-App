import 'package:flutter/material.dart';
import 'package:my_daktari/constants/constants.dart' as constants;

class DoctorsTab extends StatelessWidget {
  const DoctorsTab({super.key});

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Align(
              alignment: Alignment.centerRight,
              child: Image.asset(
                'assets/images/my_daktari_blue.png',
                height: 200,
              )),
          const SizedBox(
            height: 30,
          ),
          const Text('Do you need help?'),
          const SizedBox(
            height: 10,
          ),
          Text(
            'Let’s Find Your Doctor',
            style: textTheme.titleLarge,
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(20.0, 20, 20, 0),
            child: TextField(
              decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.search),
                  hintText: 'Search doctor, conditions or procedures',
                  hintStyle: const TextStyle(fontSize: 12),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(21))),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: TextField(
              decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.location_on),
                  hintText: 'Current Location',
                  hintStyle: const TextStyle(fontSize: 12),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(21))),
            ),
          ),
          Center(
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: constants.primaryColor),
                  onPressed: () {},
                  child: const Text('Search')))
        ],
      ),
    );
  }
}
