import 'package:flutter/material.dart';
import 'package:geeruh/api/api_build.dart';
import 'package:geeruh/api/api_requests.dart';
import 'package:geeruh/gee_user_info.dart';
import 'package:geeruh/global_constants.dart';
import 'package:geeruh/main.dart';
import 'package:geeruh/theme.dart';
import 'package:geeruh/widgets/gee_avatar.dart';
import 'package:provider/provider.dart';

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
  late ApiRequests _api;

  @override
  Widget build(BuildContext context) {
    _api = Provider.of<ApiRequests>(context);
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
                Navigator.of(context).pushNamedAndRemoveUntil(
                  '/',
                  ModalRoute.withName('/'),
                );
                apiRequest(_api.logout(), context);
              },
              icon: geeAvatar(UserInfo.userId!,
                  UserInfo.userName == null ? "" : UserInfo.userName!, 30)),
        ),
      ],
    );
  }
}
