import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '/utils/const/const.dart';
import '/views/widgets/custom_auth_button.dart';
import '/views/widgets/drawer_widget.dart';
import '/views/widgets/main_information_widget.dart';
import '/views/widgets/profile_picture.dart';
import '/views/widgets/social_button.dart';

class MyAccountScreen extends StatelessWidget {
  const MyAccountScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    void openLink({required String url}) async {
      if (!await launch(url)) throw "Error occurred couldn't open link";
    }

    var deviceSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0.0,
        iconTheme: const IconThemeData(color: kDarkBlue),
      ),
      drawer: const DrawerWidget(),
      body: SingleChildScrollView(
        child: Stack(
          alignment: AlignmentDirectional.center,
          children: [
            Card(
              margin: const EdgeInsets.symmetric(horizontal: 30),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).orientation ==
                            Orientation.landscape
                        ? deviceSize.height / 2
                        : deviceSize.height / 8,
                  ),
                  Text(
                    'Hussein Elbhrawy',
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.headline6!.copyWith(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  Text(
                    'Team Leader Since 2022 - 7 - 8 ',
                    style: Theme.of(context).textTheme.headline6!.copyWith(
                          color: kDarkBlue,
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  const Divider(color: kDarkBlue),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const MainInformationWidget(
                        title1: 'Contact Info👇',
                        title2: '',
                      ),
                      const MainInformationWidget(
                        title1: 'Email',
                        title2: 'hussein.elbhrawu74@gmail.com',
                      ),
                      const MainInformationWidget(
                        title1: 'Phone Number',
                        title2: '01069233929',
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            SocialButton(
                              iconColor: Colors.green,
                              iconData: Icons.whatsapp_outlined,
                              onTap: () {
                                openLink(
                                  url:
                                      'https://wa.me/01069233929?text=HelloThere',
                                );
                              },
                            ),
                            SocialButton(
                              iconColor: Colors.red,
                              iconData: Icons.mail_outlined,
                              onTap: () {
                                openLink(url: 'mailto:email@gmail.com');
                              },
                            ),
                            SocialButton(
                              iconColor: Colors.purple,
                              iconData: Icons.call_outlined,
                              onTap: () {
                                openLink(url: 'tel://01069233929');
                              },
                            ),
                          ],
                        ),
                      ),
                      const Divider(
                        color: kDarkBlue,
                        thickness: .9,
                        endIndent: 40,
                        indent: 40,
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          vertical: 15,
                          horizontal: 25,
                        ),
                        child: CustomAuthButton(
                          title: 'Sign Out',
                          icon: Icons.exit_to_app_outlined,
                          onTap: () {},
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Align(
              alignment: AlignmentDirectional.topCenter,
              heightFactor:
                  MediaQuery.of(context).orientation == Orientation.landscape
                      ? 3
                      : 4.5,
              child: ProfilePicture(deviceSize: deviceSize),
            ),
          ],
        ),
      ),
    );
  }
}
