import 'package:flutter/material.dart';
import 'package:geeruh/global_constants.dart';
import 'package:geeruh/main.dart';
import 'package:geeruh/theme.dart';
import 'package:geeruh/widgets/gee_avatar.dart';

class GeeNavBar extends StatefulWidget implements PreferredSizeWidget {
  const GeeNavBar({
    super.key,
  });

  @override
  State<GeeNavBar> createState() => _GeeNavBarState();

  @override
  Size get preferredSize {
    return const Size.fromHeight(50.0);
  }
}

class _GeeNavBarState extends State<GeeNavBar> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: const Text(
        "Geeruh",
        style: GeeTextStyles.heading1,
      ),
      backgroundColor: GeeColors.primary1,
      leading: Padding(
        padding: const EdgeInsets.all(5),
        child: Image.asset("images/LogoIcon.png", color: GeeColors.white),
      ),
      actions: [
        IconButton(
            onPressed: () {
              Navigator.pushNamed(
                  navigatorKey.currentContext!, ConstantScreens.startScreen);
            },
            icon: Image.asset("images/Team.png")),
        SizedBox(
          height: 60,
          width: 60,
          child: IconButton(
              onPressed: () {
                //TODO actual id and name
              },
              icon: geeAvatar(1, "Maks", 30)),
        ),
      ],
    );
  }
}
