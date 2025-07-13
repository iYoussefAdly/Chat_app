import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:scholar_chat/Screens/login_page.dart';
import 'package:scholar_chat/Widgets/constants.dart';
import 'package:scholar_chat/Widgets/custom_button.dart';
import 'package:scholar_chat/Widgets/custom_text_field.dart';
import 'package:scholar_chat/cubits/regiseter_cubit/register_cubit.dart';
import 'package:scholar_chat/helpers/show_snack_bar.dart';

class RegisterPage extends StatelessWidget {
  static String id = 'RegisterPage';
  String? email;
  String? password;
  bool? isLoading = false;
  GlobalKey<FormState> formKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RegisterCubit, RegisterState>(
      listener: (context, state) {
        if (state is RegisterLoading) {
          isLoading = true;
        } else if (state is RegisterSuccess) {
          showSnackBar(context, "Success");
          Navigator.pushNamed(context, LoginPage.id);
          isLoading = false;
        } else if (state is RegisterFailure) {
          isLoading = false;
          showSnackBar(context, state.errorMessage);
        }
      },
      builder: (context, state) {
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
                            'Register',
                            style: TextStyle(color: Colors.white, fontSize: 26),
                          ),
                        ],
                      ),
                    ),
                    CustomTextFormField(
                      labelText: 'Email',
                      hintText: 'enter your email',
                      onChanged: (data) {
                        email = data;
                      },
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
                      title: 'Register',
                      onTap: () async {
                        if (formKey.currentState!.validate()) {
                          BlocProvider.of<RegisterCubit>(
                            context,
                          ).register(email: email!, password: password!);
                        }
                      },
                    ),
                    SizedBox(height: 14),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'have an accout?',
                          style: TextStyle(color: Colors.white),
                        ),
                        GestureDetector(
                          onTap: () => Navigator.pop(context),
                          child: Text(
                            'Log in',
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
      },
    );
  }

  Future<void> registerUser() async {
    UserCredential user = await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email!, password: password!);
  }
}
