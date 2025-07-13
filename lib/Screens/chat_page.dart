import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scholar_chat/Widgets/chat_bubble.dart';
import 'package:scholar_chat/Widgets/constants.dart';
import 'package:scholar_chat/Widgets/send_text_field.dart';
import 'package:scholar_chat/cubits/chat_cubit/chat_cubit.dart';
import 'package:scholar_chat/models/message.dart';

class ChatPage extends StatelessWidget {
  List<Message> messagesList = [];
  static String id = 'ChatPage';
  final TextEditingController controller = TextEditingController();
  final ScrollController controller2 = ScrollController();
  @override
  Widget build(BuildContext context) {
    String email = ModalRoute.of(context)!.settings.arguments as String;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(kLogo, height: 55),
            Text('Chat me', style: TextStyle(color: Colors.white)),
          ],
        ),
        backgroundColor: kPrimayColor,
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: BlocConsumer<ChatCubit, ChatState>(
              listener: (context, state) {
                if (state is ChatSuccess) {
                  messagesList=state.messagesList;
                }
              },
              builder: (context, state) {
                return ListView.builder(
                  reverse: true,
                  controller: controller2,
                  itemCount: messagesList.length,
                  itemBuilder: (context, index) {
                    return messagesList[index].id == email
                        ? ChatBubble(message: messagesList[index])
                        : ChatBubbleForFriends(message: messagesList[index]);
                  },
                );
              },
            ),
          ),
          SendTextField(
            controller: controller,
            onSubmitted: (data) {
              BlocProvider.of<ChatCubit>(
                context,
              ).sendMessage(message: data, email: email);
              controller.clear();
              controller2.animateTo(
                0,
                duration: Duration(seconds: 1),
                curve: Curves.easeIn,
              );
            },
          ),
        ],
      ),
    );
  }
}
