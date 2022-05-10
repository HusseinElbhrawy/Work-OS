import 'package:flutter/material.dart';
import 'package:work_os/views/screens/inner_chat/widgets/send_message_widget.dart';

class EmptyChatWidget extends StatelessWidget {
  const EmptyChatWidget({
    Key? key,
    required this.userData,
  }) : super(key: key);

  final Map<String, dynamic> userData;

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Container(
          margin: const EdgeInsets.only(top: 100),
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Image.asset('assets/images/chat.png'),
            ),
          ),
        ),
        SizedBox(height: MediaQuery.of(context).size.height / 5.5),
        Align(
          alignment: AlignmentDirectional.bottomCenter,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: SendMessageWidget(sendTo: userData['id']),
          ),
        ),
      ],
    );
  }
}
