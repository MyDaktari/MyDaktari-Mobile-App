import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../models/blood_sugar.dart';
import '../../../../repositories/shared_repositories/blood_sugar/blood_sugar_repository.dart';

part 'blood_sugar_event.dart';
part 'blood_sugar_state.dart';

class BloodSugarBloc extends Bloc<BloodSugarEvent, BloodSugarState> {
  final BloodSugarRepository repository;
  BloodSugarBloc({required BloodSugarRepository repository})
      : repository = repository,
        super(BloodSugarInitial()) {
    on<LoadBloodSugarRecord>(_onLoadBloodSugarRecord);
    on<AddBloodSugarRecord>(_onAddBloodSugarRecord);
  }
  void _onLoadBloodSugarRecord(
      LoadBloodSugarRecord event, Emitter<BloodSugarState> emit) async {
    emit(BloodSugarLoading());
    try {
      List<BloodSugarModel> records =
          await repository.getBloodRecord(userId: event.userId);
      records.sort((a, b) =>
          DateTime.parse(a.dateTime!).compareTo(DateTime.parse(b.dateTime!)));
      //calculate average
      double average = 0;
      double highest = 0;
      double lowest = 0;
      if (records.isNotEmpty) {
        average = records
                .map((record) => record.glucoseLevel!)
                .reduce((a, b) => a + b) /
            records.length;
        highest = records
            .map((record) => record.glucoseLevel!)
            .reduce((a, b) => a > b ? a : b);
        lowest = records
            .map((record) => record.glucoseLevel!)
            .reduce((a, b) => a < b ? a : b);
      }
      emit(BloodSugarLoadSuccess(
          records: records,
          average: average,
          highest: highest,
          lowest: lowest));
    } catch (error) {
      final message = error.toString().contains("host lookup")
          ? 'Connect to the internet '
          : error.toString().split("Exception:").last;
      emit(BloodSugarsLoadinFailed(message: message));
    }
  }

  void _onAddBloodSugarRecord(
      AddBloodSugarRecord event, Emitter<BloodSugarState> emit) async {
    emit(BloodSugarLoading());
    try {
      await repository.addBloodRecord(
          userId: event.userId,
          glucoseLevel: event.glucoseLevel,
          date: event.date,
          time: event.time,
          timeBase: event.timeBase);
      List<BloodSugarModel> records =
          await repository.getBloodRecord(userId: event.userId);
      records.sort((a, b) =>
          DateTime.parse(a.dateTime!).compareTo(DateTime.parse(b.dateTime!)));
      //calculate average
      double average = 0;
      double highest = 0;
      double lowest = 0;
      if (records.isNotEmpty) {
        average = records
                .map((record) => record.glucoseLevel!)
                .reduce((a, b) => a + b) /
            records.length;
        highest = records
            .map((record) => record.glucoseLevel!)
            .reduce((a, b) => a > b ? a : b);
        lowest = records
            .map((record) => record.glucoseLevel!)
            .reduce((a, b) => a < b ? a : b);
      }
      emit(BloodSugarLoadSuccess(
          records: records,
          average: average,
          highest: highest,
          lowest: lowest));
    } catch (error) {
      final message = error.toString().contains("host lookup")
          ? 'Connect to the internet '
          : error.toString().split("Exception:").last;
      emit(BloodSugarsLoadinFailed(message: message));
    }
  }
}
