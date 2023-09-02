import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../constants/colors.dart';
import '../../../../logic/bloc/shared_bloc/chat/chat_bloc.dart';

class ChatInputField extends StatelessWidget {
  final TextEditingController _controller = TextEditingController();

  void _sendMessage(BuildContext context) {
    final message = _controller.text.trim();
    if (message.isNotEmpty) {
      context.read<ChatBloc>().add(SendMessage(message: message));
      //  _controller.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: TextField(
            controller: _controller,
            decoration: const InputDecoration(hintText: 'Type a message'),
          ),
        ),
        IconButton(
          icon: Icon(
            Icons.send,
            size: 30,
            color: AppColor.primaryColor,
          ),
          onPressed: () => _sendMessage(context),
        ),
      ],
    );
  }
}
