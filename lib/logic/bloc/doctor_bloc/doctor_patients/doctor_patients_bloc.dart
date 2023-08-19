import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:my_daktari/models/models.dart';
import 'package:my_daktari/repositories/doctor/doctor_repository.dart';

part 'doctor_patients_event.dart';
part 'doctor_patients_state.dart';

class DoctorPatientsBloc
    extends Bloc<DoctorPatientsEvent, DoctorPatientsState> {
  final DoctorRepository doctorRepository;
  DoctorPatientsBloc({required DoctorRepository doctorRepository})
      : doctorRepository = doctorRepository,
        super(DoctorPatientsLoading()) {
    on<LoadDoctorPatients>(_onLoadDoctorPatients);
  }
  void _onLoadDoctorPatients(
      LoadDoctorPatients event, Emitter<DoctorPatientsState> emit) async {
    emit(DoctorPatientsLoading());
    try {
      List<PatientModel> patients =
          await doctorRepository.getDoctorPatients(doctorId: event.doctorId);
      emit(DoctorPatientsLoaded(patients: patients));
    } catch (error) {
      String errorMessage = error.toString().contains("host lookup")
          ? 'Connect to the internet '
          : error.toString().split("Exception:").last;
      emit(DoctorPatientsLoadingError(message: errorMessage));
    }
  }
}
