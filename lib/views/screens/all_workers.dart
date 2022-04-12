import 'package:flutter/material.dart';
import 'package:work_os/utils/const/const.dart';
import 'package:work_os/views/screens/home.dart';
import 'package:work_os/views/widgets/drawer_widget.dart';
import 'package:work_os/views/widgets/filter_dialog.dart';

class AllWorkersScreen extends StatelessWidget {
  const AllWorkersScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var deviceSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'All Workers',
          style: TextStyle(
            color: Colors.pink.shade800,
          ),
        ),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0.0,
        iconTheme: const IconThemeData(color: kDarkBlue),
        actions: [
          IconButton(
            onPressed: () {
              buildFilterDialog(
                deviceSize,
                tasksCategoryList: HomeScreen.tasksCategoryList,
              );
            },
            icon: Icon(
              Icons.filter_list_outlined,
              color: Colors.grey.shade700,
            ),
          ),
        ],
      ),
      drawer: const DrawerWidget(),
      body: ListView.builder(
        itemCount: 10,
        itemBuilder: (context, index) {
          return Card(
            margin: EdgeInsetsDirectional.all(4),
            child: ListTile(
              contentPadding:
                  EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              leading: Container(
                decoration: BoxDecoration(
                  border: BorderDirectional(
                    end: BorderSide(color: kDarkBlue, width: 2),
                  ),
                ),
                child: Container(
                  margin: const EdgeInsetsDirectional.only(end: 10),
                  child: Image.asset(
                    'assets/images/man.png',
                  ),
                  decoration: BoxDecoration(
                    color: Colors.blueAccent.shade100,
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              title: Text(
                'Name',
                style: Theme.of(context).textTheme.headline6!.copyWith(
                      color: kDarkBlue,
                      fontWeight: FontWeight.bold,
                    ),
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.linear_scale,
                    color: Colors.pink.shade800,
                  ),
                  const Text(
                    'SubTitle / Description',
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontSize: 16),
                  ),
                ],
              ),
              trailing: Icon(
                Icons.mail_outlined,
                size: 30,
                color: Colors.pink[800],
              ),
            ),
          );
        },
      ),
    );
  }
}
