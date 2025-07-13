import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:scholar_chat/Screens/chat_page.dart';
import 'package:scholar_chat/Screens/register_page.dart';
import 'package:scholar_chat/Widgets/constants.dart';
import 'package:scholar_chat/Widgets/custom_button.dart';
import 'package:scholar_chat/Widgets/custom_text_field.dart';
import 'package:scholar_chat/cubits/login_cubit/login_cubit.dart';
import 'package:scholar_chat/helpers/show_snack_bar.dart';

class LoginPage extends StatelessWidget {
  String? email;
  static String id = 'LoginPage';
  String? password;
  bool isLoading = false;

  GlobalKey<FormState> formKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginCubit, LoginState>(
      listener: (context, state) {
        if (state is LoginLoading) {
          isLoading = true;
        } else if (state is LoginSuccess) {
          Navigator.pushNamed(context, ChatPage.id,arguments: email);
          isLoading = false;
        } else if (state is LoginFailure) {
          showSnackBar(context, state.errorMessage);
          isLoading = false;
        }
      },
      builder:
          (context, index) => ModalProgressHUD(
            inAsyncCall: isLoading,
            child: Scaffold(
              backgroundColor: kPrimayColor,
              body: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Form(
                  key: formKey,
                  child: ListView(
                    children: [
                      SizedBox(height: 92),
                      SizedBox(height: 100, child: Image.asset(kLogo)),
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
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 26,
                              ),
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
                            BlocProvider.of<LoginCubit>(
                              context,
                            ).login(email: email!, password: password!);
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
                                () => Navigator.pushNamed(
                                  context,
                                  RegisterPage.id,
                                ),
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
          ),
    );
  }
}
