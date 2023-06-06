part of 'body_parts_bloc.dart';

abstract class BodyPartsState extends Equatable {
  const BodyPartsState();

  @override
  List<Object> get props => [];
}

class BodyPartsLoading extends BodyPartsState {}

class BodyPartsLoaded extends BodyPartsState {
  final List<BodyPartModel> bodyParts;

  const BodyPartsLoaded({this.bodyParts = const <BodyPartModel>[]});
  @override
  List<Object> get props => [bodyParts];
}

class BodyPartsLoadingError extends BodyPartsState {
  final String message;

  const BodyPartsLoadingError({required this.message});
  @override
  List<Object> get props => [message];
}
