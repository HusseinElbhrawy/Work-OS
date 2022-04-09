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
  }) : super(key: key);

  final TextEditingController controller;
  final Function(String? value) validator;
  final String labelText;
  final TextInputType keyboardType;
  final IconData? suffixIcon;
  final Function? suffixIconFunction;
  final bool obscureText;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      validator: (value) => validator(value),
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
        errorBorder: buildUnderlineInputBorder().copyWith(
          borderSide: const BorderSide(
            color: Colors.red,
          ),
        ),
        labelStyle: const TextStyle(
          color: Colors.white,
        ),
      ),
    );
  }
}
