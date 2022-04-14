import 'package:flutter/material.dart';
import 'package:work_os/utils/const/const.dart';
import 'package:work_os/views/widgets/add_task_screen_custom_widget.dart';
import 'package:work_os/views/widgets/profile_picture.dart';

class TaskDetailsScreen extends StatelessWidget {
  const TaskDetailsScreen({Key? key}) : super(key: key);
  static bool _isCommenting = false;
  static List<Color> profileBorderColor = [
    Colors.red,
    Colors.blue,
    Colors.green,
    Colors.yellow,
    Colors.orange,
    Colors.teal,
    Colors.amber,
  ];
  @override
  Widget build(BuildContext context) {
    profileBorderColor.shuffle();
    var deviceSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Center(
              child: Text(
                'Develop an App',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                      color: kDarkBlue,
                      fontWeight: FontWeight.bold,
                    ),
              ),
            ),
            Card(
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const CustomText(title: 'Uploaded By'),
                        const Spacer(),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 0),
                          child: Row(
                            children: [
                              ProfilePicture(deviceSize: deviceSize),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: const [
                                  Text('Name'),
                                  Text('Job'),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const Divider(color: kDarkBlue),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const CustomText(title: 'Uploaded on:'),
                        const CustomText(title: '2021-7-9'),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const CustomText(title: 'Deadline date:'),
                        const CustomText(title: '2021-7-31'),
                      ],
                    ),
                    const Divider(color: kDarkBlue),
                    const CustomText(title: 'Done Status'),
                    Row(
                      children: [
                        const Text('Done'),
                        const VerticalDivider(width: 40),
                        const Text('Not Done Yet'),
                        Checkbox(
                          onChanged: (bool? value) {},
                          value: true,
                        ),
                      ],
                    ),
                    const Divider(color: kDarkBlue),
                    const CustomText(title: 'Task Description'),
                    const Text('Description for task'),
                    ListTile(
                      leading: CircleAvatar(
                        radius: 23,
                        backgroundColor: Colors.red,
                        child: CircleAvatar(
                          backgroundColor: Colors.white,
                          // backgroundImage: AssetImage('assets/images/man.png'),
                          child: Image.asset(
                            'assets/images/man.png',
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      title: const Text('Name'),
                      subtitle: const Text('Job'),
                    ),
                    Center(
                      child: StatefulBuilder(
                        builder: (BuildContext context,
                            void Function(void Function()) setState) {
                          return AnimatedSwitcher(
                            duration: const Duration(milliseconds: 500),
                            child: _isCommenting
                                ? Row(
                                    children: [
                                      Expanded(
                                        child: AddTaskScreenCustomWidget(
                                          onTap: () {},
                                          title: 'Comment',
                                          hint: 'Comment',
                                          maxLines: 5,
                                          maxLength: 1000,
                                        ),
                                        flex: 3,
                                      ),
                                      Expanded(
                                          child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Column(
                                          children: [
                                            MaterialButton(
                                              onPressed: () {},
                                              child: const Text('Post'),
                                              textColor: Colors.white,
                                              color: Colors.pink.shade800,
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(15),
                                              ),
                                            ),
                                            MaterialButton(
                                              onPressed: () {
                                                setState(() {
                                                  _isCommenting = false;
                                                });
                                              },
                                              child: const Text('Cancel'),
                                              textColor: Colors.red,
                                            ),
                                          ],
                                        ),
                                      )),
                                    ],
                                  )
                                : MaterialButton(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    color: Colors.pink.shade800,
                                    textColor: Colors.white,
                                    onPressed: () {
                                      setState(() {
                                        _isCommenting = true;
                                      });
                                    },
                                    child: const Text(
                                      'Add a comment',
                                    ),
                                  ),
                          );
                        },
                      ),
                    ),
                    ListView.separated(
                      shrinkWrap: true,
                      itemCount: 10,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        return ListTile(
                          leading: CircleAvatar(
                            radius: 23,
                            backgroundColor: profileBorderColor.elementAt(0),
                            child: CircleAvatar(
                              backgroundColor: Colors.white,
                              // backgroundImage: AssetImage('assets/images/man.png'),
                              child: Image.asset(
                                'assets/images/man.png',
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          title: const Text('Name'),
                          subtitle: const Text('Job'),
                        );
                      },
                      separatorBuilder: (BuildContext context, int index) =>
                          Divider(thickness: 1.1),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CustomText extends StatelessWidget {
  const CustomText({
    Key? key,
    required this.title,
  }) : super(key: key);
  final String title;
  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: Theme.of(context).textTheme.headline6?.copyWith(
            color: kDarkBlue,
            fontWeight: FontWeight.bold,
          ),
    );
  }
}
