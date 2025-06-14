import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:scholar_chat/Screens/chat_page.dart';
import 'package:scholar_chat/Screens/register_page.dart';
import 'package:scholar_chat/Widgets/constants.dart';
import 'package:scholar_chat/Widgets/custom_button.dart';
import 'package:scholar_chat/Widgets/custom_text_field.dart';
import 'package:scholar_chat/helpers/show_snack_bar.dart';

class LoginPage extends StatefulWidget {
  LoginPage({super.key});
  static String id = 'LoginPage';

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String? email;

  String? password;

  bool? isLoading = false;

  GlobalKey<FormState> formKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: isLoading!,
      child: Scaffold(
        backgroundColor: kPrimayColor,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Form(
            key: formKey,
            child: ListView(
              children: [
                SizedBox(height: 92),
                SizedBox(
                  height: 100,
                  child: Image.asset(kLogo),
                ),
                Center(
                  child: Text(
                    'Chat me',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 32,
                      fontFamily: 'pacifico',
                    ),
                  ),
                ),
                SizedBox(height: 75),

                Padding(
                  padding: const EdgeInsets.only(bottom: 15),
                  child: Row(
                    children: [
                      Text(
                        'Log in',
                        style: TextStyle(color: Colors.white, fontSize: 26),
                      ),
                    ],
                  ),
                ),
                CustomTextFormField(
                  onChanged: (data) {
                    email = data;
                  },
                  labelText: 'Email',
                  hintText: 'enter your email',
                ),
                SizedBox(height: 10),
                CustomTextFormField(
                  obscureText: true,
                  onChanged: (data) {
                    password = data;
                  },
                  labelText: 'Password',
                  hintText: 'enter your password',
                ),
                SizedBox(height: 28),
                CustomButton(
                  title: 'Sign in',
                  onTap: () async {
                    if (formKey.currentState!.validate()) {
                      isLoading = true;
                      setState(() {});
                      try {
                        await signInUser();
                        Navigator.pushNamed(context, ChatPage.id,arguments: email);
                      } catch (e) {
                       
                        showSnackBar(context, 'user not found');
                      }
                      isLoading = false;
                      setState(() {});
                    }
                  },
                ),
                SizedBox(height: 14),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'don\'t have an accout?',
                      style: TextStyle(color: Colors.white),
                    ),
                    GestureDetector(
                      onTap:
                          () => Navigator.pushNamed(context, RegisterPage.id),
                      child: Text(
                        ' Register',
                        style: TextStyle(color: Color(0xff97AEC7)),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> signInUser() async {
    UserCredential user = await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email!, password: password!);
  }
}
