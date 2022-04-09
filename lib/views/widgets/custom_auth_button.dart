import 'package:flutter/material.dart';

class CustomAuthButton extends StatelessWidget {
  const CustomAuthButton({
    Key? key,
    required this.formKey,
  }) : super(key: key);

  final GlobalKey<FormState> formKey;

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      padding: const EdgeInsets.symmetric(vertical: 13),
      elevation: 10,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(13), side: BorderSide.none),
      color: Colors.pink.shade700,
      onPressed: () {
        FocusScope.of(context).unfocus();
        if (formKey.currentState!.validate()) {}
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Login',
            style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
          ),
          const VerticalDivider(color: Colors.transparent),
          const Icon(
            Icons.login,
            color: Colors.white,
          ),
        ],
      ),
    );
  }
}
