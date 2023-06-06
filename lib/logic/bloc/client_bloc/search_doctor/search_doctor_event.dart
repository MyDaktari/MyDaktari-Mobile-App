part of 'search_doctor_bloc.dart';

abstract class SearchDoctorEvent extends Equatable {
  const SearchDoctorEvent();

  @override
  List<Object> get props => [];
}

class SearchDoctors extends SearchDoctorEvent {
  final String searchTerm;
  final BuildContext context;
  const SearchDoctors({required this.searchTerm, required this.context});
  @override
  List<Object> get props => [searchTerm, context];
}
