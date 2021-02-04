import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:news_app/models/users.dart';
import 'package:news_app/utils/app_theme_utils.dart';
import 'package:news_app/utils/app_utils.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'login.dart';

class UserSettingsPage extends StatefulWidget {
  @override
  _UserSettingsPageState createState() => _UserSettingsPageState();
}

class _UserSettingsPageState extends State<UserSettingsPage> {
  User _user;
  SharedPreferences prefs;

  @override
  void initState() {
    _getUserDetails();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final consumer = Consumer<UserModel>(
      builder: (ctx, value, child) {
        if (value.user != null) {
          _user = value.user;
          print('consumer: ${_user.name}');
        }
        final profileImage = _user?.profileImagePath?.isNotEmpty == true
            ? Image.file(
                File(_user.profileImagePath),
                width: 150,
                height: 150,
                fit: BoxFit.fill,
              )
            : Image.asset(
                "assets/ic_profile_dummy.png",
                width: 150,
                height: 150,
                fit: BoxFit.fill,
              );
        final imageParent = ClipRRect(
          borderRadius: BorderRadius.all(Radius.circular(32)),
          child: profileImage,
        );
        final textContainer = Container(
            child: Column(children: [
          Text(_user?.name ?? "",
              style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold)),
          Text(_user?.email ?? "", style: TextStyle(fontSize: 20))
        ]));
        final listView = ListView(
          padding: EdgeInsets.all(16),
          children: [
            Column(
              children: [
                SizedBox(
                  height: 50,
                ),
                imageParent,
                SizedBox(
                  height: 16,
                ),
                textContainer,
                SizedBox(
                  height: 16,
                ),
                getAppFlatBtn("Log out", _logout)
              ],
            )
          ],
        );
        return listView;
      },
    );
    return Container(
      color: AppColors.beige,
      child: consumer,
    );
  }

  void _logout() {
    showOkAlert(context, "Log out", "Are you sure you want to log out?",
        okText: "Log out", showCancel: true, okAction: () {
      prefs.remove("user");
      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (ctx) {
        return LoginPage();
      }));
    });
  }

  void _getUserDetails() async {
    prefs = await SharedPreferences.getInstance();
    String userJson = prefs.getString("user");
    if (userJson?.isEmpty != false) return;
    final user = userFromJson(userJson);
    setState(() {
      _user = user;
    });
  }
}
