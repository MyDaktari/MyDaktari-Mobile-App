import 'package:flutter/material.dart';
import 'package:my_daktari/constants/constants.dart' as constants;
import 'package:my_daktari/mock/service/get_doctor_service.dart';
import 'package:provider/provider.dart';

import '../widgets/result_section.dart';

class DoctorsTab extends StatelessWidget {
  DoctorsTab({super.key});
  final TextEditingController _searchController = TextEditingController();
  final SearchTermNotifier _searchTermNotifier = SearchTermNotifier(value: '');
  bool valuesReset = false;

  resetValues(GetDoctor getDoctor) {
    getDoctor.resetResultReturned();
    valuesReset = true;
  }

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    Size size = MediaQuery.of(context).size;
    return Consumer<GetDoctor>(builder: (context, getDoctor, _) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        !valuesReset ? resetValues(getDoctor) : null;
      });
      return ValueListenableBuilder(
          valueListenable: _searchTermNotifier,
          builder: (context, value, _) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListView(
                //  crossAxisAlignment: CrossAxisAlignment.start,
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
                    child: Focus(
                      child: TextField(
                        style: const TextStyle(color: Colors.grey),
                        onChanged: (value) {
                          _searchTermNotifier.newValue = value;
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
                            SizedBox(
                              width: 10,
                            ),
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
                          onPressed: value.isEmpty
                              ? null
                              : () {
                                  FocusScope.of(context)
                                      .requestFocus(FocusNode());
                                  getDoctor
                                      .search(_searchController.text.trim());
                                },
                          child: const Text('Search'))),
                  const ResultSection()
                ],
              ),
            );
          });
    });
  }
}

class SearchTermNotifier extends ValueNotifier<String> {
  SearchTermNotifier({required String value}) : super(value);
  set newValue(String value) {
    this.value = value;
  }
}
