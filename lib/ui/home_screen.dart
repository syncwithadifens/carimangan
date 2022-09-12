import 'package:flutter/material.dart';
import 'package:carimangan/data/preferences/preferences_helper.dart';
import 'package:carimangan/provider/preferences_provider.dart';
import 'package:carimangan/provider/scheduling_provider.dart';
import 'package:carimangan/ui/detail_screen.dart';
import 'package:carimangan/ui/restaurant_list_page.dart';
import 'package:carimangan/ui/setting_page.dart';
import 'package:carimangan/utils/notification_helper.dart';
import 'package:carimangan/widgets/platform_widget.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'favorite_page.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);
  static const routeName = '/home_screen';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _bottomNavIndex = 0;
  static const String _homeText = 'Home';
  static const String _bookmarksText = 'Favorite';
  static const String _settingsText = 'Setting';

  final NotificationHelper _notificationHelper = NotificationHelper();

  final List<Widget> _listWidget = [
    const RestaurantListPage(),
    const BookmarkPage(),
    MultiProvider(
      providers: [
        ChangeNotifierProvider<SchedulingProvider>(
          create: (_) => SchedulingProvider(),
        ),
        ChangeNotifierProvider<PreferencesProvider>(
          create: (_) => PreferencesProvider(
            preferencesHelper: PreferencesHelper(
              sharedPreferences: SharedPreferences.getInstance(),
            ),
          ),
        )
      ],
      child: const SettingPage(),
    )
  ];

  final List<BottomNavigationBarItem> _bottomNavBarItems = [
    const BottomNavigationBarItem(
      icon: Icon(Icons.home),
      label: _homeText,
    ),
    const BottomNavigationBarItem(
      icon: Icon(Icons.favorite),
      label: _bookmarksText,
    ),
    const BottomNavigationBarItem(
      icon: Icon(Icons.settings),
      label: _settingsText,
    ),
  ];

  void _onBottomNavTaped(int index) {
    setState(() {
      _bottomNavIndex = index;
    });
  }

  Widget _buildAndroid(BuildContext context) {
    return Scaffold(
      body: _listWidget[_bottomNavIndex],
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.brown,
        showUnselectedLabels: false,
        currentIndex: _bottomNavIndex,
        onTap: _onBottomNavTaped,
        items: _bottomNavBarItems,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return PlatformWidget(
      androidBuilder: _buildAndroid,
      iosBuilder: _buildAndroid,
    );
  }

  @override
  void initState() {
    super.initState();
    _notificationHelper
        .configureSelectNotificationSubject(DetailScreen.routeName);
  }

  @override
  void dispose() {
    selectNotificationSubject.close();
    super.dispose();
  }
}
