import 'package:flutter/material.dart';
import 'package:weather/controller/global_controller.dart';
import 'package:weather/tabs/home_tab.dart';

import '../tabs/city_tab.dart';
import '../tabs/setting_tab.dart';
import '../widgets/bottom_tabs.dart';

class LandingScreen extends StatefulWidget {
  const LandingScreen({Key? key}) : super(key: key);

  @override
  State<LandingScreen> createState() => _LandingScreenState();
}

class _LandingScreenState extends State<LandingScreen> {
  late PageController _tabsPageController;

  int _selectedTab = GlobalController().changeTabIndex();

  @override
  void initState() {
    _tabsPageController = PageController();
    super.initState();
  }

  @override
  void dispose() {
    _tabsPageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
              child: PageView(
            controller: _tabsPageController,
                children: const [HomeTab(), CityTab(), SettingTab()],

            onPageChanged: (number) {
              setState(() {
                _selectedTab = number;
              });
            },
          )),
          BottomTabs(
            selectedTab: _selectedTab,
            tabPressed: (number) {
              _tabsPageController.animateToPage(number,
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeOutCubic);
            },
          )
        ],
      ),
    );
  }
}
