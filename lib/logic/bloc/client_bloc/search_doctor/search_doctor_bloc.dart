import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:my_daktari/models/doctor_profile_model.dart';
import 'package:my_daktari/repositories/client/client_repository.dart';

part 'search_doctor_event.dart';
part 'search_doctor_state.dart';

class SearchDoctorBloc extends Bloc<SearchDoctorEvent, SearchDoctorState> {
  final ClientRepository repository;
  SearchDoctorBloc({required ClientRepository repository})
      : repository = repository,
        super(SearchDoctorInitialized()) {
    on<SearchDoctors>(_onSearchDoctors);
  }
  void _onSearchDoctors(
      SearchDoctors event, Emitter<SearchDoctorState> emit) async {
    try {
      if (event.searchTerm.isNotEmpty && event.searchTerm.length > 2) {
        emit(SearchDoctorLoading());
        List<DoctorProfileModel> doctors =
            await repository.searchDoctors(event.searchTerm);
        emit(SearchDoctorLoaded(doctors: doctors));
      } else {
        ScaffoldMessenger.of(event.context).showSnackBar(
            const SnackBar(content: Text('search term too short')));
      }
    } catch (error) {
      String errorMessage = error.toString().contains("host lookup")
          ? 'Connect to the internet '
          : error.toString().split("Exception:").last;
      emit(SearchDoctorLoadingError(errorMessage: errorMessage));
    }
  }
}
