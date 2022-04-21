import 'package:flutter/material.dart';
import 'package:work_os/utils/const/const.dart';

class AddTaskScreenCustomWidget extends StatelessWidget {
  const AddTaskScreenCustomWidget({
    Key? key,
    required this.onTap,
    required this.title,
    required this.hint,
    this.enabled = true,
    this.maxLength,
    this.maxLines,
    this.textEditingController,
  }) : super(key: key);
  final String title, hint;
  final Function onTap;
  final bool enabled;
  final int? maxLines, maxLength;
  final TextEditingController? textEditingController;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '$title*',
          style: Theme.of(context).textTheme.headline6!.copyWith(
                color: Colors.pink.shade700,
              ),
        ),
        GestureDetector(
          onTap: () => onTap(),
          // focusColor: Colors.transparent,
          child: TextFormField(
            cursorColor: kDarkBlue,
            controller: textEditingController,
            key: Key(title),
            enabled: enabled,
            maxLines: maxLines,
            maxLength: maxLength,
            validator: (newValue) {
              if (newValue!.isEmpty || newValue.length < 7) {
                return 'Filed is missing, This comment may less than 7 chars';
              }
              return null;
            },
            style: const TextStyle(color: kDarkBlue),
            keyboardType: TextInputType.text,
            decoration: InputDecoration(
              filled: true,
              fillColor: kScaffoldBGColor,
              hintText: hint,
              hintStyle: const TextStyle(fontWeight: FontWeight.bold),
              focusedBorder: _buildUnderlineInputBorder(),
              enabledBorder: _buildUnderlineInputBorder(),
              errorBorder: _buildUnderlineInputBorder().copyWith(
                borderSide: const BorderSide(color: Colors.red),
              ),
            ),
          ),
        ),
      ],
    );
  }

  UnderlineInputBorder _buildUnderlineInputBorder() {
    return UnderlineInputBorder(
      borderSide: BorderSide(
        color: Colors.pink.shade800,
      ),
    );
  }
}
