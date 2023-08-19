import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_daktari/models/body_part_model.dart';
import 'package:my_daktari/repositories/client/bodyparts/body_parts_repository.dart';

part 'body_parts_event.dart';
part 'body_parts_state.dart';

class BodyPartsBloc extends Bloc<BodyPartsEvent, BodyPartsState> {
  BodyPartsRepository _bodyPartsRepository;
  BodyPartsBloc({required BodyPartsRepository bodyPartsRepository})
      : _bodyPartsRepository = bodyPartsRepository,
        super(BodyPartsLoading()) {
    on<LoadBodyParts>(_onLoadBodyParts);
  }
  void _onLoadBodyParts(
      LoadBodyParts event, Emitter<BodyPartsState> emit) async {
    emit(BodyPartsLoading());
    try {
      List<BodyPartModel>? bodyParts =
          await _bodyPartsRepository.getBodyParts();
      emit(BodyPartsLoaded(bodyParts: bodyParts));
    } catch (error) {
      String errorMessage = error.toString().contains("host lookup")
          ? 'Connect to the internet '
          : error.toString().split("Exception:").last;
      emit(BodyPartsLoadingError(message: errorMessage));
    }
  }
}
