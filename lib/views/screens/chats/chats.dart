import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:getwidget/components/shimmer/gf_shimmer.dart';
import 'package:work_os/controller/style_controller.dart';
import 'package:work_os/utils/const/const.dart';
import 'package:work_os/utils/styles/theme.dart';
import 'package:work_os/views/screens/home/home.dart';
import 'package:work_os/views/screens/inner_chat/inner_chat.dart';
import 'package:work_os/views/widgets/loading_widget.dart';
import 'package:work_os/views/widgets/zoom_drawer.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final StyleController styleController = Get.find();
    return CustomZoomDrawer(
      child: Scaffold(
        appBar: AppBar(
          title: Text('chats_screen'.tr),
          leading: CustomLeadingButton(styleController: styleController),
        ),
        body: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('chats')
              .doc(FirebaseAuth.instance.currentUser!.uid)
              .collection('chatWith')
              .snapshots(),
          builder: (BuildContext context,
              AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
            log(FirebaseAuth.instance.currentUser!.uid);
            if (snapshot.connectionState == ConnectionState.waiting) {
              return ListView.builder(
                itemCount: 100,
                physics: const BouncingScrollPhysics(),
                itemBuilder: (BuildContext context, int index) =>
                    const GFShimmer(
                  child: LoadingWidget(),
                ),
              );
            } else if (snapshot.hasError) {
              return Center(
                child: Text(
                  'something_error'.tr,
                  style: styleController.isDarkTheme
                      ? CustomDarkTheme.headline6(context)
                      : CustomLightTheme.headline6(context),
                ),
              );
            } else if (snapshot.data!.docs.isEmpty) {
              return Center(
                child: Container(
                  margin: const EdgeInsets.all(25),
                  child: Image.asset(
                    'assets/images/chat.png',
                  ),
                ),
              );
            } else {
              return RefreshIndicator(
                onRefresh: () async {},
                child: ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (BuildContext context, int index) {
                    return AnimationConfiguration.staggeredList(
                      position: index,
                      duration: const Duration(milliseconds: 1200),
                      child: SlideAnimation(
                        horizontalOffset: 500,
                        child: FadeInAnimation(
                          child: Directionality(
                            textDirection: TextDirection.ltr,
                            child: ChatScreenItemWidget(
                              id: snapshot.data!.docs[index].id,
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              );
            }
          },
        ),
      ),
    );
  }
}

class ChatScreenItemWidget extends StatefulWidget {
  const ChatScreenItemWidget({
    Key? key,
    required this.id,
  }) : super(key: key);
  final String id;

  @override
  State<ChatScreenItemWidget> createState() => _ChatScreenItemWidgetState();
}

class _ChatScreenItemWidgetState extends State<ChatScreenItemWidget> {
  bool isLoading = false;
  late DocumentSnapshot<Map<String, dynamic>> data;
  late QuerySnapshot<Map<String, dynamic>> last;

  void getAllData() async {
    isLoading = true;
    data = await FirebaseFirestore.instance
        .collection('users')
        .doc(widget.id)
        .get();

    last = await FirebaseFirestore.instance
        .collection('chats')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('chatWith')
        .doc(widget.id)
        .collection('messages')
        .limit(1)
        .orderBy('timestamp')
        .get();
    isLoading = false;
    setState(() {});
  }

  @override
  void initState() {
    getAllData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? const GFShimmer(
            child: LoadingWidget(),
          )
        : GetBuilder(
            builder: (StyleController controller) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                child: Card(
                  color: controller.isDarkTheme
                      ? kDarkModeItemColor
                      : Colors.white,
                  child: ListTile(
                    contentPadding: const EdgeInsets.all(8),
                    onTap: () {
                      Get.to(
                        () => const InnerCharScreen(),
                        arguments: {
                          'id': data['Id'],
                          'name': data['Name'],
                          'imageUrl': data['ImageUrl'],
                        },
                      );
                    },
                    leading: CircleAvatar(
                      backgroundColor: Colors.red,
                      backgroundImage: NetworkImage(data['ImageUrl']),
                      radius: 25,
                    ),
                    title: Text(data['Name']),
                    subtitle: Text(last.docs.first.data()['messageContent'] ??
                        'Voice Note'),
                  ),
                ),
              );
            },
          );
  }
}
