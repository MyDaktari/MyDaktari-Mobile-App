import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../models/appointment.dart';
import '../../../../repositories/doctor/doctor_repository.dart';

part 'doctor_appointments_event.dart';
part 'doctor_appointments_state.dart';

class DoctorAppointmentsBloc
    extends Bloc<DoctorAppointmentsEvent, DoctorAppointmentsState> {
  final DoctorRepository doctorRepository;
  DoctorAppointmentsBloc({required DoctorRepository doctorRepository})
      : doctorRepository = doctorRepository,
        super(DoctorAppointmentsLoading()) {
    on<LoadDoctorAppointments>(_onLoadDoctorAppointments);
  }
  void _onLoadDoctorAppointments(LoadDoctorAppointments event,
      Emitter<DoctorAppointmentsState> emit) async {
    emit(DoctorAppointmentsLoading());
    try {
      List<AppointmentModel> appointments = await doctorRepository
          .getDoctorAppointments(doctorId: event.doctorId);
      emit(DoctorAppointmentsLoaded(appointments: appointments));
    } catch (error) {
      String errorMessage = error.toString().contains("host lookup")
          ? 'Connect to the internet '
          : error.toString().split("Exception:").last;
      emit(DoctorAppointmentsLoadingError(message: errorMessage));
    }
  }
}
