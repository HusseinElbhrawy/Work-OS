import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:work_os/views/screens/inner_chat/widgets/message_item_widget.dart';
import 'package:work_os/views/screens/inner_chat/widgets/send_message_widget.dart';

class FullChatWidget extends StatelessWidget {
  const FullChatWidget({
    Key? key,
    required this.userData,
    required this.snapshot,
  }) : super(key: key);

  final Map<String, dynamic> userData;
  final AsyncSnapshot<QuerySnapshot<Map>> snapshot;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, index) {
              return MessageItemWidget(
                message: snapshot.data!.docs[index].data()['messageContent'],
                timestamp: snapshot.data!.docs[index].data()['timestamp'],
              );
            },
          ),
        ),
        Align(
          alignment: AlignmentDirectional.bottomCenter,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: SendMessageWidget(sendTo: userData['id']),
          ),
        ),
        const SizedBox(height: 10),
      ],
    );
  }
}
