import 'package:flutter/material.dart';
import 'package:simfonie/Text/text_all_widget.dart';
import 'package:simfonie/screens/MainScreens/SettingsScreens/AboutScreen.dart';
import 'package:simfonie/screens/MainScreens/SettingsScreens/TermsAndCondition.dart';
import 'package:simfonie/screens/MainScreens/SettingsScreens/privacy-policy.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color.fromARGB(255, 20, 5, 46),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                const Text(
                  'Settings',
                  style: TextStyle(
                      overflow: TextOverflow.ellipsis,
                      fontFamily: 'poppins',
                      color: Colors.white,
                      fontSize: 23),
                ),
                const SizedBox(
                  height: 10,
                ),
                InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => AboutScreen(),
                        ));
                  },
                  child: ListSettings(
                    titleText: TextAllWidget.settingAboutSimfonie,
                    yourIcon: Icons.info_outline,
                  ),
                ),
                InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => TermsAndConditionScreen(),
                        ));
                  },
                  child: ListSettings(
                    titleText: TextAllWidget.settingTermsAndCondition,
                    yourIcon: Icons.gavel_rounded,
                  ),
                ),
                InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => PrivacyPolicyScreen(),
                        ));
                  },
                  child: ListSettings(
                    titleText: TextAllWidget.settingPrivacyPolicy,
                    yourIcon: Icons.privacy_tip_outlined,
                  ),
                ),
                ListSettings(
                  titleText: TextAllWidget.settingShareSimfonie,
                  yourIcon: Icons.share_outlined,
                )
              ],
            ),
          ),
        ));
  }
}

class ListSettings extends StatelessWidget {
  const ListSettings({
    Key? key,
    required this.titleText,
    required this.yourIcon,
  }) : super(key: key);
  // ignore: prefer_typing_uninitialized_variables
  final titleText;
  final IconData yourIcon;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        color: const Color.fromARGB(255, 18, 2, 61),
        shadowColor: Colors.purpleAccent,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5),
            side: const BorderSide(color: Color.fromARGB(255, 132, 0, 255))),
        child: ListTile(
          iconColor: Colors.white,
          selectedColor: Colors.purpleAccent,
          leading: Icon(yourIcon),
          title: Text(
            titleText,
            style: const TextStyle(
                overflow: TextOverflow.ellipsis,
                fontFamily: 'poppins',
                color: Colors.white),
          ),
        ),
      ),
    );
  }
}
