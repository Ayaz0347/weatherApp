import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'controllers/main_controller.dart';
import 'main.dart';
class MainDrawer extends StatelessWidget {
  const MainDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() => Drawer(
       backgroundColor: controller.isDark.value ? Colors.black : Colors.white,
      child: Column(children: [
        Padding(
          padding: const EdgeInsets.only(top: 50.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: const [
              CircleAvatar(
                radius: 50.0,
                backgroundImage: AssetImage("assets/icons/ayaz.png"),              ),
              SizedBox(
                height: 5.0,
              ),
              Text(
                "Ayaz Khan",
                style: TextStyle(
                  fontSize: 22.0,
                  fontWeight: FontWeight.w800,
                  color: Colors.white
                ),
              ),
              SizedBox(
                height: 5.0,
              ),
              Text(
                "Software Engineer",
                style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 20.0,
        ),
        //Now let's Add the button for the Menu
        //and let's copy that and modify it
        ListTile(
          onTap: () {},
          leading: const Icon(
            Icons.person,
            color: Colors.black,
          ),
          title: const Text("Your Profile"),
        ),

        ListTile(
          onTap: () {},
          leading: const Icon(
            Icons.inbox,
            color: Colors.black,
          ),
          title: const Text("Your Inbox"),
        ),

        ListTile(
          onTap: () {},
          leading: const Icon(
            Icons.assessment,
            color: Colors.black,
          ),
          title: const Text("Your Dashboard"),
        ),

        ListTile(
          onTap: () {},
          leading: const Icon(
            Icons.settings,
            color: Colors.black,
          ),
          title: const Text("Settings"),
        ),
      ]),
    ));
  }
}
