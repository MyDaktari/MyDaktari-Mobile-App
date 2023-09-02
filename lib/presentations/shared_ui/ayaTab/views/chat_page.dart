import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_daktari/constants/colors.dart';

import '../../../../logic/bloc/shared_bloc/chat/chat_bloc.dart';
import '../widget/send_text_field.dart';

class ChatBotScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Aya'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: BlocBuilder<ChatBloc, ChatState>(
              builder: (context, state) {
                if (state is ChatInitial) {
                  return Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircleAvatar(
                          radius: 105,
                          backgroundColor: AppColor.lightGreen,
                          child: CircleAvatar(
                            backgroundColor: Colors.white,
                            radius: 100,
                            child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Image.asset('assets/images/aya-half.png',
                                    fit: BoxFit.fitHeight)),
                          ),
                        ),
                        SizedBox(height: 10.0),
                        Text('Hello, I\'m Aya',
                            style: TextStyle(
                                fontSize: 30, fontWeight: FontWeight.bold)),
                        SizedBox(height: 10.0),
                        Text(
                          'Your very own MyDaktari Assistant. I work 24/7 to enhance your MyDaktari experience and available at the touch of a button.',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 16, color: AppColor.blackText),
                        ),
                      ],
                    ),
                  );
                } else if (state is ChatLoading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state is ChatSuccess) {
                  return Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: ListView.builder(
                      itemCount: state.response.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          title: Text(state.response[index]),
                        );
                      },
                    ),
                  );
                } else if (state is ChatError) {
                  return Center(
                    child: Text('Error: ${state.error}'),
                  );
                }
                return Container();
              },
            ),
          ),
          Padding(padding: const EdgeInsets.all(8.0), child: ChatInputField()),
        ],
      ),
    );
  }
}
