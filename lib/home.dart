import 'package:flutter/material.dart';
import 'package:news_app/favorites.dart';
import 'package:news_app/user_settings.dart';

import 'edit_profile.dart';
import 'news_list.dart';

class HomePage extends StatefulWidget {
  final _pages = [
    NewsListPage(),
    FavoritePage(),
    UserSettingsPage(),
  ];
  final _titles = [
    "News",
    "Favorites",
    "Settings",
  ];

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    List<Widget> appBarActions;
    if (_selectedIndex == 2) {
      appBarActions = [
        IconButton(icon: Icon(Icons.mode_edit), onPressed: _openEditProfile)
      ];
    }
    final scaffold = Scaffold(
      appBar: AppBar(
        title: Text(widget._titles[_selectedIndex]),
        actions: appBarActions,
      ),
      body: widget._pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        onTap: _onTabSelected,
        items: [
          BottomNavigationBarItem(
              icon: ImageIcon(AssetImage("assets/ic_news_list.png")),
              activeIcon:
              ImageIcon(AssetImage("assets/ic_news_list_active.png")),
              label: "News"),
          BottomNavigationBarItem(
              activeIcon: Icon(Icons.favorite),
              icon: Icon(Icons.favorite_border),
              label: "Favorites"),
          BottomNavigationBarItem(
              icon: Icon(Icons.settings_outlined),
              activeIcon: Icon(Icons.settings),
              label: "Settings"),
        ],
      ),
    );
    return scaffold;
  }

  void _onTabSelected(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _openEditProfile() {
    Navigator.of(context).push(MaterialPageRoute(builder: (ctx) {
      return EditProfilePage();
    }));
  }
}
