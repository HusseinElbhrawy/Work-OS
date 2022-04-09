import 'package:flutter/material.dart';
import 'package:work_os/views/widgets/taks_widget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: false,
      drawer: const Drawer(),
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.grey.shade900),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0.0,
        title: Text(
          'Task',
          style: TextStyle(
            color: Colors.pink.shade600,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.filter_list_outlined,
              color: Colors.grey.shade700,
            ),
          ),
        ],
      ),
      body: ListView.builder(
        itemBuilder: (context, index) {
          return TaskWidget();
        },
      ),
    );
  }
}
