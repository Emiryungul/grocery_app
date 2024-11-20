import 'package:flutter/material.dart';
import '../../utils/app_colors.dart';

class ProfileSettingWidget extends StatelessWidget {
  const ProfileSettingWidget({super.key, required this.ContainerColor, required this.IconColor, required this.icon, required this.text, required this.func, required this.textStyle});
  final Color ContainerColor;
  final Color IconColor;
  final IconData icon;
  final String text;
  final Function func;
  final TextStyle textStyle;


  @override
  Widget build(BuildContext context) {
    return  GestureDetector(
      onTap: ()=>func(),
      child: Container(
        width: double.infinity,
        height: 55,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: ContainerColor
        ),
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Row(
            children: [
              Icon(icon,color: IconColor,),
              SizedBox(width: 25,),
              Text(text,style: textStyle,),
              Spacer(),
              Icon(Icons.arrow_forward_ios,color: AppColors.whiteAppColor,)
            ],
          ),
        ),
      ),
    );
  }
}
