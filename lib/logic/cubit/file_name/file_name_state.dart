part of 'file_name_cubit.dart';

class FileNameState extends Equatable {
  final String certificate;
  final String nationalId;

  const FileNameState({required this.certificate, required this.nationalId});

  FileNameState copyWith({String? certificate, String? nationalId}) {
    return FileNameState(
      certificate: certificate ?? this.certificate,
      nationalId: nationalId ?? this.nationalId,
    );
  }

  @override
  List<Object> get props => [certificate, nationalId];
}
