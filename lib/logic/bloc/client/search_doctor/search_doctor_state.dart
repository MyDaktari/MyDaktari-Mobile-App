part of 'search_doctor_bloc.dart';

abstract class SearchDoctorState extends Equatable {
  const SearchDoctorState();

  @override
  List<Object> get props => [];
}

class SearchDoctorInitialized extends SearchDoctorState {}

class SearchDoctorLoading extends SearchDoctorState {}

class SearchDoctorLoaded extends SearchDoctorState {
  final List<DoctorProfileModel> doctors;

  const SearchDoctorLoaded({required this.doctors});
  @override
  List<Object> get props => [doctors];
}

class SearchDoctorLoadingError extends SearchDoctorState {
  final String errorMessage;

  SearchDoctorLoadingError({required this.errorMessage});
  @override
  List<Object> get props => [errorMessage];
}
