import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:scholar_chat/Screens/chat_page.dart';
import 'package:scholar_chat/Screens/login_page.dart';
import 'package:scholar_chat/Screens/register_page.dart';
import 'package:scholar_chat/firebase_options.dart';

void main() async{
    WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(ScholarChat());
}

class ScholarChat extends StatelessWidget {
  const ScholarChat({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        RegisterPage.id:(context)=>RegisterPage(),
        LoginPage.id:(context)=>LoginPage(),
        ChatPage.id:(context)=>ChatPage(),
      },
      debugShowCheckedModeBanner: false,
      initialRoute: LoginPage.id);
  }
}
