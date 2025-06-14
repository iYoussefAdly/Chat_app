import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
   CustomButton({required this.title,required this.onTap});
 final String title;
 final VoidCallback? onTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
        ),
      
        width: double.infinity,
        height: 50,
        child: Center(child: Text('$title', style: TextStyle(fontSize: 18))),
      ),
    );
  }
}
