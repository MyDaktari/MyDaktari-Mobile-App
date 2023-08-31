import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../models/medication.dart';
import '../../../../repositories/shared_repositories/medication/medication_repository.dart';

part 'medication_event.dart';
part 'medication_state.dart';

class MedicationBloc extends Bloc<MedicationEvent, MedicationState> {
  final MedicationRepository repository;
  MedicationBloc({required MedicationRepository repository})
      : repository = repository,
        super(MedicationInitial()) {
    on<LoadMedicationRecord>(_onLoadMedicationRecord);
    on<AddMedicationRecord>(_onAddMedicationRecord);
  }
  void _onLoadMedicationRecord(
      LoadMedicationRecord event, Emitter<MedicationState> emit) async {
    emit(MedicationLoading());
    try {
      List<MedicationModel> records =
          await repository.getMedicationRecord(userId: event.userId);
      records.sort((a, b) =>
          DateTime.parse(a.dateTime!).compareTo(DateTime.parse(b.dateTime!)));

      emit(MedicationLoadSuccess(records: records));
    } catch (error) {
      final message = error.toString().contains("host lookup")
          ? 'Connect to the internet '
          : error.toString().split("Exception:").last;
      emit(MedicationsLoadinFailed(message: message));
    }
  }

  void _onAddMedicationRecord(
      AddMedicationRecord event, Emitter<MedicationState> emit) async {
    emit(MedicationLoading());
    try {
      await repository.addMedicationRecord(
          userId: event.userId,
          glucoseLevel: event.glucoseLevel,
          date: event.date,
          time: event.time,
          timeBase: event.timeBase);
      List<MedicationModel> records =
          await repository.getMedicationRecord(userId: event.userId);
      records.sort((a, b) =>
          DateTime.parse(a.dateTime!).compareTo(DateTime.parse(b.dateTime!)));

      emit(MedicationLoadSuccess(records: records));
    } catch (error) {
      final message = error.toString().contains("host lookup")
          ? 'Connect to the internet '
          : error.toString().split("Exception:").last;
      emit(MedicationsLoadinFailed(message: message));
    }
  }
}
