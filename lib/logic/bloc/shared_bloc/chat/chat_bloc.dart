import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../repositories/shared_repositories/chat_bot/chat_repository.dart';

part 'chat_event.dart';
part 'chat_state.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  final ChatBotRepository repository;
  ChatBloc({required this.repository}) : super(ChatInitial()) {
    on<SendMessage>(_onSendMessage);
  }

  void _onSendMessage(ChatEvent event, Emitter<ChatState> emit) async {
    if (event is SendMessage) {
      emit(ChatLoading());
      try {
        final response = await repository.sendMessage(event.message);
        emit(ChatSuccess(response: response));
      } catch (error) {
        final message = error.toString().contains("host lookup")
            ? 'Connect to the internet '
            : error.toString().split("Exception:").last;
        emit(ChatError(error: message));
      }
    }
  }
}
