import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'file_name_state.dart';

class FileNameCubit extends Cubit<FileNameState> {
  FileNameCubit()
      : super(const FileNameState(
            certificate: 'Upload Certificate (pdf)',
            nationalId: 'Upload Your National Id'));
  void setNationIdFileName({required String fileName}) =>
      emit(state.copyWith(nationalId: fileName));
  void setCertificateFileName({required String fileName}) =>
      emit(state.copyWith(certificate: fileName));
}
