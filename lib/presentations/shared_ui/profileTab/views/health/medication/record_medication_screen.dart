import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:my_daktari/constants/colors.dart';
import 'package:my_daktari/constants/constants.dart';
import 'package:my_daktari/logic/bloc/shared_bloc/medication/medication_bloc.dart';

import '../../../../../../constants/enums.dart';
import '../../../../../../logic/bloc/shared_bloc/blood_sugar/blood_sugar_bloc.dart';

class RecordMedicationScreen extends StatefulWidget {
  const RecordMedicationScreen({super.key});

  @override
  _RecordMedicationScreenScreenState createState() =>
      _RecordMedicationScreenScreenState();
}

class _RecordMedicationScreenScreenState extends State<RecordMedicationScreen> {
  late TextEditingController _medicinNameController;
  late TextEditingController _dosageController;
  late TextEditingController _noteController;
  DateTime _selectedDateTime = DateTime.now();
  MealType _selectedMealType = MealType.beforeMeal;

  @override
  void initState() {
    super.initState();
    _medicinNameController = TextEditingController();
    _dosageController = TextEditingController();
    _noteController = TextEditingController();
  }

  @override
  void dispose() {
    _medicinNameController.dispose();
    _dosageController.dispose();
    _noteController.dispose();
    super.dispose();
  }

  Future<void> _selectDate(BuildContext context) async {
    final selectedDate = await showDatePicker(
      context: context,
      initialDate: _selectedDateTime,
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
    );

    if (selectedDate != null) {
      setState(() {
        _selectedDateTime = DateTime(
          selectedDate.year,
          selectedDate.month,
          selectedDate.day,
          _selectedDateTime.hour,
          _selectedDateTime.minute,
        );
      });
    }
  }

  Future<void> _selectTime(BuildContext context) async {
    final selectedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.fromDateTime(_selectedDateTime),
    );

    if (selectedTime != null) {
      setState(() {
        _selectedDateTime = DateTime(
            _selectedDateTime.year,
            _selectedDateTime.month,
            _selectedDateTime.day,
            selectedTime.hour,
            selectedTime.minute);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
          title: const Text('Medications',
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold)),
          centerTitle: true),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: AppColor.primaryColor.withOpacity(.1)),
              child: TextField(
                controller: _medicinNameController,
                keyboardType: TextInputType.name,
                decoration: InputDecoration(
                  labelText: 'Medication Name',
                  labelStyle: TextStyle(fontWeight: FontWeight.bold),
                  border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.all(Radius.circular(8.0)),
                  ),
                ),
              ),
            ),
            SizedBox(height: 15),
            Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: AppColor.primaryColor.withOpacity(.1)),
              child: TextField(
                controller: _dosageController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Dosage (units)',
                  labelStyle: TextStyle(fontWeight: FontWeight.bold),
                  border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.all(Radius.circular(8.0)),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: DropdownButtonFormField<MealType>(
                value: _selectedMealType.name == 'Before Meal'
                    ? MealType.beforeMeal
                    : MealType.afterMeal,
                onChanged: (value) {
                  setState(() {
                    _selectedMealType = value!;
                  });
                },
                items: MealType.values.map((type) {
                  return DropdownMenuItem<MealType>(
                      value: type,
                      child: Text(type == MealType.beforeMeal
                          ? 'Before Meal'
                          : 'After Meal'));
                }).toList(),
                decoration: InputDecoration(
                    labelText: 'Time base',
                    labelStyle: TextStyle(color: Colors.black)),
              ),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                  onTap: () => _selectDate(context),
                  child: Container(
                    width: size.width * .4,
                    height: 50,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: AppColor.primaryColor.withOpacity(.1)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Icon(Icons.date_range,
                            color: AppColor.primaryColor, size: 30),
                        const SizedBox(width: 8),
                        Text(
                          DateFormat('dd/MM/yyyy').format(_selectedDateTime),
                          style: TextStyle(fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                  ),
                ),
                InkWell(
                  onTap: () => _selectTime(context),
                  child: Container(
                    width: size.width * .4,
                    height: 50,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: AppColor.primaryColor.withOpacity(.1)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Icon(Icons.access_time,
                            color: AppColor.primaryColor, size: 30),
                        const SizedBox(width: 8),
                        Text(
                          DateFormat.jm().format(_selectedDateTime),
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                //all fields are required (glucose level, date, time, time base

                final note = _noteController.text;
                if (_medicinNameController.text.isNotEmpty &&
                    _dosageController.text.isNotEmpty &&
                    _selectedDateTime != null &&
                    _selectedMealType != null) {
                  context.read<MedicationBloc>().add(AddMedicationRecord(
                        userId: userId,
                        timeBase: _selectedMealType.toString(),
                        date:
                            DateFormat('yyyy-MM-dd').format(_selectedDateTime),
                        time: DateFormat('HH:mm').format(_selectedDateTime),
                        dosage: double.parse(_dosageController.text),
                        medicineName: _medicinNameController.text,
                      ));
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('All fields are required'),
                    ),
                  );
                }
              },
              style:
                  ElevatedButton.styleFrom(minimumSize: Size(size.width, 50)),
              child: BlocConsumer<MedicationBloc, MedicationState>(
                listener: (context, state) {
                  if (state is MedicationLoadSuccess) {
                    Fluttertoast.showToast(
                        msg: 'Medication record added successfully');
                  }
                  if (state is MedicationsLoadinFailed) {
                    Fluttertoast.showToast(msg: state.message);
                  }
                },
                builder: (context, state) {
                  if (state is MedicationLoading) {
                    return const CupertinoActivityIndicator(
                        color: Colors.white);
                  }
                  return const Text('Save', style: TextStyle(fontSize: 18));
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
