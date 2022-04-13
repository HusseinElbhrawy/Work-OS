import 'package:flutter/material.dart';
import 'package:work_os/utils/const/const.dart';

class MainInformationWidget extends StatelessWidget {
  const MainInformationWidget({
    Key? key,
    required this.title1,
    required this.title2,
  }) : super(key: key);
  final String title1, title2;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Text(
            '$title1:',
            style: Theme.of(context).textTheme.headline6!.copyWith(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
          ),
          Text(
            title2,
            style: const TextStyle(
              color: kDarkBlue,
              fontSize: 15,
            ),
          ),
        ],
      ),
    );
  }
}
