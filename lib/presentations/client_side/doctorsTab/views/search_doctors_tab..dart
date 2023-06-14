import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../logic/bloc/client_bloc/search_doctor/search_doctor_bloc.dart';
import '../widgets/result_section.dart';
import '/constants/constants.dart' as constants;

// ignore: must_be_immutable
class DoctorsTab extends StatelessWidget {
  DoctorsTab({super.key});
  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    Size size = MediaQuery.of(context).size;

    return Padding(
      padding: EdgeInsets.all(size.width * .03),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(left: size.width * .21),
              child:
                  Image.asset('assets/images/my_daktari_blue.png', height: 200),
            ),
            const SizedBox(height: 30),
            const Text('Do you need help?'),
            const SizedBox(height: 10),
            Text('Let’s Find Your Doctor', style: textTheme.titleLarge),
            Padding(
              padding: const EdgeInsets.fromLTRB(20.0, 20, 20, 0),
              child: Focus(
                child: TextField(
                  style: const TextStyle(color: Colors.grey),
                  onSubmitted: (value) {
                    print(value);
                    print(value.length);
                    value.trim().isEmpty
                        ? null
                        : value.length < 2
                            ? ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text('search term too short')))
                            : FocusScope.of(context).requestFocus(FocusNode());
                    context.read<SearchDoctorBloc>().add(SearchDoctors(
                        searchTerm: value.toString(), context: context));
                  },
                  controller: _searchController,
                  decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.search),
                      hintText: 'Search doctor or procedures',
                      hintStyle: const TextStyle(fontSize: 12),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(21))),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Container(
                height: 55,
                width: size.width,
                decoration: BoxDecoration(
                    border: Border.all(),
                    borderRadius: BorderRadius.circular(21)),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: const [
                      Icon(Icons.location_on),
                      SizedBox(width: 10),
                      Text('Current Location')
                    ],
                  ),
                ),
              ),
            ),
            Center(
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: constants.primaryColor),
                    onPressed: () {
                      FocusScope.of(context).requestFocus(FocusNode());
                      context.read<SearchDoctorBloc>().add(SearchDoctors(
                          searchTerm: _searchController.text.toString(),
                          context: context));
                    },
                    child: const Text('Search'))),
            const ResultSection()
          ],
        ),
      ),
    );
  }
}

// class SearchTermNotifier extends ValueNotifier<String> {
//   SearchTermNotifier({required String value}) : super(value);
//   set newValue(String value) {
//     this.value = value;
//   }
// }
