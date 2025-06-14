import 'package:flutter/material.dart';
import 'package:scholar_chat/Widgets/constants.dart';

class SendTextField extends StatelessWidget {
  SendTextField({required this.onSubmitted,required this.controller});
  final Function(String)? onSubmitted;
  final TextEditingController controller;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: TextField(
        controller: controller,
        onSubmitted: onSubmitted,
        decoration: InputDecoration(
          hintText: 'Send a message',
          suffixIcon: Icon(Icons.send, color: kPrimayColor),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: kPrimayColor),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(13),
            borderSide: BorderSide(color: kPrimayColor),
          ),
        ),
      ),
    );
  }
}
