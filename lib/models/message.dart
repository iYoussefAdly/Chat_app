import 'package:scholar_chat/Widgets/constants.dart';

class Message {
  final String message;
  final String id;
  Message(this.message, this.id);

  factory Message.fromJson(json) {
      if (!json.containsKey(kId) || !json.containsKey(kMessage)) {
      print('⚠️ Missing fields in Firestore data: $json');
  }
    return Message(json[kMessage]??'',json[kId]??'');
  }
}
