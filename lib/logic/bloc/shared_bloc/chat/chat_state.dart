part of 'chat_bloc.dart';

abstract class ChatState extends Equatable {
  const ChatState();
  @override
  List<Object?> get props => [];
}

class ChatInitial extends ChatState {}

class ChatLoading extends ChatState {}

class ChatSuccess extends ChatState {
  final String response;
  const ChatSuccess({required this.response});
  @override
  List<Object?> get props => [response];
}

class ChatError extends ChatState {
  final String error;
  const ChatError({required this.error});
  @override
  List<Object?> get props => [error];
}
