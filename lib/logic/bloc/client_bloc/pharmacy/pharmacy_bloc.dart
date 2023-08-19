import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:my_daktari/models/pharmacy.dart';
import 'package:my_daktari/repositories/client/pharmacy/pharmacy_repository.dart';

part 'pharmacy_event.dart';
part 'pharmacy_state.dart';

class PharmacyBloc extends Bloc<PharmacyEvent, PharmacyState> {
  PharmacyRepository _pharmacyRepository;
  PharmacyBloc({required PharmacyRepository pharmacyRepository})
      : _pharmacyRepository = pharmacyRepository,
        super(PharmacyLoading()) {
    on<LoadPharmacy>(_onLoadPharmacy);
  }
  void _onLoadPharmacy(LoadPharmacy event, Emitter<PharmacyState> emit) async {
    emit(PharmacyLoading());
    try {
      List<PharmacyModel> pharmacyList =
          await _pharmacyRepository.getPharmacy();
      emit(PharmacyLoaded(pharmacyList: pharmacyList));
    } catch (error) {
      String errorMessage = error.toString().contains("host lookup")
          ? 'Connect to the internet '
          : error.toString().split("Exception:").last;
      emit(PharmacyLoadingError(message: errorMessage));
    }
  }
}
