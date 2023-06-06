part of 'complete_profile_bloc.dart';

abstract class CompleteProfileState extends Equatable {
  const CompleteProfileState();

  @override
  List<Object> get props => [];
}

class CompleteProfileInitial extends CompleteProfileState {}

class CompleteProfileLoading extends CompleteProfileState {}

class CompleteProfileLoaded extends CompleteProfileState {}

class CompleteProfileLoadError extends CompleteProfileState {
  final String message;
  const CompleteProfileLoadError({required this.message});
  @override
  List<Object> get props => [message];
}
