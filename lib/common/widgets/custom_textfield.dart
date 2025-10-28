import 'package:flutter/material.dart';

import '../theme/app_colors.dart';

class CustomTextField extends StatefulWidget {
  CustomTextField({
    super.key,
    this.hintText,
    this.validator,
    this.prefixIcon,
    this.hintColor,
    this.maxLines = 1,
    this.controller,
    this.isPassword = false,
    this.onChanged,
  });

  final String? hintText;
  final String? Function(String?)? validator;
  final Widget? prefixIcon;
  final Color? hintColor;
  final int? maxLines;
  final TextEditingController? controller;
  final bool isPassword;
  void Function(String)? onChanged;

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  late bool isPassword = widget.isPassword;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      maxLines: widget.maxLines,
      validator: widget.validator,
      style: const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w500,
        color: AppColors.whiteColor,
      ),
      obscureText: isPassword,
      decoration: InputDecoration(
        filled: true,
        fillColor: AppColors.darkGray,

        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16)
        ),
        focusedBorder: _getBorder(AppColors.whiteColor),

        errorBorder: _getBorder(AppColors.redColor),
        hintText: widget.hintText,
        hintStyle: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w400,
          color: AppColors.whiteColor,
        ),
        prefixIcon:
            widget.prefixIcon == null
                ? null
                : Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: widget.prefixIcon,
                ),
        suffixIcon:
            widget.isPassword
                ? IconButton(
                  onPressed: () {
                    setState(() {
                      isPassword = !isPassword;
                    });
                  },
                  icon: Icon(
                    isPassword ? Icons.visibility_off : Icons.remove_red_eye,color: AppColors.whiteColor,size: 30,
                  ),
                )
                : null,
      ),
      onChanged: widget.onChanged,
    );
  }

  _getBorder(Color color) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(16),
      borderSide: BorderSide(color: color),
    );
  }
}
