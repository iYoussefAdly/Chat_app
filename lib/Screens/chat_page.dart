import 'package:flutter/material.dart';
import 'package:scholar_chat/Screens/loading_page.dart';
import 'package:scholar_chat/Widgets/chat_bubble.dart';
import 'package:scholar_chat/Widgets/constants.dart';
import 'package:scholar_chat/Widgets/send_text_field.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:scholar_chat/models/message.dart';

class ChatPage extends StatelessWidget {
  static String id = 'ChatPage';
  final CollectionReference messages = FirebaseFirestore.instance.collection(
    kMessagesColloection,
  );
  final TextEditingController controller = TextEditingController();
  final ScrollController controller2 = ScrollController();
  @override
  Widget build(BuildContext context) {
  var email=ModalRoute.of(context)!.settings.arguments;
    return StreamBuilder<QuerySnapshot>(
      stream: messages.orderBy(kCreatedAt, descending: true).snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasData) { 
          List<Message> messagesList = [];
          for (int i = 0; i < snapshot.data!.docs.length; i++) {
            messagesList.add(Message.fromJson(snapshot.data!.docs[i]));
          }
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
                  child: ListView.builder(
                    reverse: true,
                    controller: controller2,
                    itemCount: messagesList.length,
                    itemBuilder: (context, index) {
                      return messagesList[index].id==email? ChatBubble(message: messagesList[index]):
                     ChatBubbleForFriends(message: messagesList[index]) ;
                    },
                  ),
                ),
                SendTextField(
                  controller: controller,
                  onSubmitted: (data) {
                    messages.add({kMessage: data, kCreatedAt: DateTime.now()
                    ,'id':email});
                    controller.clear();
                    controller2.animateTo(
                      0,
                      duration: Duration(seconds: 2),
                      curve: Curves.ease,
                    );
                  },
                ),
              ],
            ),
          );
        } else {
          return LoadingPage();
        }
      },
    );
  }
}
