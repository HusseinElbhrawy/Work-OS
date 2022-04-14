import 'package:flutter/material.dart';
import 'package:work_os/views/widgets/build_underline_inputborder.dart';

class CustomTextFormFiled extends StatelessWidget {
  const CustomTextFormFiled({
    Key? key,
    required this.controller,
    required this.validator,
    required this.labelText,
    required this.keyboardType,
    this.suffixIcon,
    this.suffixIconFunction,
    required this.obscureText,
    required this.focusNode,
    required this.textInputAction,
    this.onEditComplete,
    this.enable = true,
    this.onTap,
  }) : super(key: key);

  final TextEditingController controller;
  final Function(String? value) validator;
  final String labelText;
  final TextInputType keyboardType;
  final IconData? suffixIcon;
  final Function? suffixIconFunction;
  final bool obscureText;
  final FocusNode focusNode;
  final TextInputAction textInputAction;
  final Function? onEditComplete;
  final bool enable;
  final Function? onTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTap!(),
      child: TextFormField(
        enabled: enable,
        focusNode: focusNode,
        textInputAction: textInputAction,
        controller: controller,
        validator: (value) => validator(value),
        onEditingComplete: () => onEditComplete!(),
        style: const TextStyle(color: Colors.white),
        keyboardType: keyboardType,
        obscureText: obscureText,
        decoration: InputDecoration(
          suffixIcon: suffixIcon != null
              ? IconButton(
                  onPressed: () => suffixIconFunction!(),
                  icon: Icon(
                    suffixIcon,
                    color: Colors.white,
                  ),
                )
              : null,
          labelText: labelText,
          fillColor: Colors.white,
          focusedBorder: buildUnderlineInputBorder(),
          enabledBorder: buildUnderlineInputBorder(),
          disabledBorder: buildUnderlineInputBorder(),
          errorBorder: buildUnderlineInputBorder().copyWith(
            borderSide: const BorderSide(
              color: Colors.red,
            ),
          ),
          labelStyle: const TextStyle(
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
