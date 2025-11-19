import 'package:flutter/material.dart';
import '../../../../common/theme/app_colors.dart';

class CustomOutlinedButton extends StatelessWidget {
  const CustomOutlinedButton({
    super.key,
    required this.onPressed,
    required this.text,
    this.fillColor,
    this.textColor,
  });

  final void Function() onPressed;
  final String text;
  final Color? fillColor;
  final Color? textColor;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: FilledButton(
        onPressed: onPressed,
        style: FilledButton.styleFrom(
          backgroundColor: AppColors.blackColor,
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
            side: const BorderSide(color: AppColors.mainColor,width: 2)
          ),
        ),
        child: Text(
          text,
          style: const TextStyle(
            color: AppColors.mainColor,
            fontSize: 20,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}
