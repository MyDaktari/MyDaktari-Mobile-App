part of 'body_parts_bloc.dart';

abstract class BodyPartsEvent extends Equatable {
  const BodyPartsEvent();

  @override
  List<Object> get props => [];
}

class LoadBodyParts extends BodyPartsEvent {}
