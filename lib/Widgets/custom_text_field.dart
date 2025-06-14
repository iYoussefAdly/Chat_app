import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  CustomTextFormField({
    super.key,
    required this.labelText,
    required this.hintText,
    required this.onChanged, 
     this.obscureText=false,
  });
  final String? hintText;
  final String? labelText;
  final Function(String)? onChanged;
  final bool? obscureText;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText:obscureText! ,
      validator:(data)
       {
                    if (data!.isEmpty) {
                      return 'Field is required';
                    } else if (data.length < 6) {
                      return 'You should type 6 char at least!';
                    }
                    return null;
                  },
      onChanged: onChanged,
      decoration: InputDecoration(
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
        ),
        hintText: '$hintText',
        hintStyle: TextStyle(color: Colors.grey),
        labelText: '$labelText',
        labelStyle: TextStyle(color: Colors.white),
      ),
    );
  }
}
