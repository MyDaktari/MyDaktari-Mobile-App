import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:my_daktari/repositories/client/client_repository.dart';

part 'book_appointment_event.dart';
part 'book_appointment_state.dart';

class BookAppointmentBloc
    extends Bloc<BookAppointmentEvent, BookAppointmentState> {
  final ClientRepository repo;
  BookAppointmentBloc({required ClientRepository repository})
      : repo = repository,
        super(BookAppointmentInitial()) {
    on<BookNewAppointment>(_onBookNewAppointment);
  }
  void _onBookNewAppointment(
      BookNewAppointment event, Emitter<BookAppointmentState> emit) async {
    emit(BookAppointmentLoading());
    try {
      Map<String, dynamic> response = await repo.addNewAppointment(
          date: event.date,
          time: event.time,
          userId: event.userId,
          doctorId: event.doctorId,
          symptomID: event.symptomID,
          description: event.description,
          meetingOption: event.meetingOption);
      emit(BookAppointmentLoaded(
        amount: response['amount'].toString(),
        appointmentID: response['appointmentID'],
      ));
    } catch (error) {
      String errorMessage = error.toString().split(':').last;
      emit(BookAppointmentLoadError(message: errorMessage));
    }
  }
}
