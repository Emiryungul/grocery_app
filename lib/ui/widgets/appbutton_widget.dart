import 'package:flutter/material.dart';
class AppButton extends StatelessWidget {
  const AppButton({super.key, required this.color, required this.text});
  final Color color;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 45,
      width: double.infinity,
      decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(5),
          boxShadow:[
            BoxShadow(
                offset:  Offset(0,1),
                blurRadius: 2.0,
                spreadRadius: 0.0
            )
          ]
      ),
      child:
      Center(
        child:
        Text(text,style: TextStyle(fontSize: 14,color: Colors.white,fontWeight: FontWeight.w600),),
      ),
    );
  }
}
