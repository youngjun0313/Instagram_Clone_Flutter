import 'package:flutter/material.dart';
import 'package:instagram_clone_flutter/screens/feed_screen.dart';
import 'package:instagram_clone_flutter/screens/profile_screen.dart';

import 'constants/screen_size.dart';

class HomePage extends StatefulWidget {
  HomePage({
    Key? key,
  }) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<BottomNavigationBarItem> btmNavItems = [
    BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
    BottomNavigationBarItem(icon: Icon(Icons.search), label: "Home"),
    BottomNavigationBarItem(icon: Icon(Icons.add), label: "Home"),
    BottomNavigationBarItem(icon: Icon(Icons.healing), label: "Home"),
    BottomNavigationBarItem(icon: Icon(Icons.account_circle), label: "Home"),
  ];

  int _selectedIndex = 0;

  List<Widget> _screens = <Widget> [
    FeedScreen(),
    Container(color: Colors.blueAccent),
    Container(color: Colors.greenAccent),
    Container(color: Colors.deepPurpleAccent),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;

    return Scaffold(
      // 그냥 바로 widget list 를 넣으면 실행시마다 새로 만들어주는 것이기 때문에 비효율적이다.
      // 그래서 IndexedStack 을 사용하는 것
      body: IndexedStack(
        index: _selectedIndex,
        children: _screens,
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: btmNavItems,
        unselectedItemColor: Colors.grey,
        selectedItemColor: Colors.black87,
        currentIndex: _selectedIndex,
        onTap: _onBtmItemClick,
        showSelectedLabels: false,
        showUnselectedLabels: false,
      ),
    );
  }

  void _onBtmItemClick (int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
}