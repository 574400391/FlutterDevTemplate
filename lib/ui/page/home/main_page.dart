import 'package:flutter/material.dart';
import 'package:flutter_dev_template/common/event_bus_enum.dart';
import 'package:flutter_dev_template/ui/page/home/tab/tab_demo.dart';
import 'package:flutter_dev_template/ui/page/home/tab/tab_settings.dart';
import 'package:flutter_dev_template/ui/res/colors.dart';
import 'package:flutter_dev_template/utils/double_tap_back_exit_app.dart';
import 'package:flutter_dev_template/utils/log_utils.dart';
import 'package:flutter_dev_template/utils/utils.dart';

List<Widget> pages = <Widget>[TabDemoPage(), TabSettingsPage()];

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  MainPageState createState() => MainPageState();
}

class MainPageState extends State<MainPage> {
  static const String _tag = "MainPage";

  final _pageController = PageController();
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    /// 注册事件监听
    Utils.eventBusOn(EventBusNameEnum.LOGIN_EVENT, (_) async {
      Log.d("login success", tag: _tag);
    });
    Utils.eventBusOn(EventBusNameEnum.LOGOUT_EVENT, (_) async {
      Log.d("logout success", tag: _tag);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: DoubleTapBackExitApp(
          child: PageView.builder(
            itemBuilder: (ctx, index) => pages[index],
            itemCount: pages.length,
            controller: _pageController,
            physics: const NeverScrollableScrollPhysics(),
            onPageChanged: (index) {
              setState(() {
                _selectedIndex = index;
              });
            },
          ),
        ),
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(
                Icons.home_outlined,
                color: Colours.app_main,
              ),
              activeIcon: Icon(
                Icons.home,
                color: Colours.app_main,
              ),
              label: 'Demo',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.settings_outlined,
                color: Colours.app_main,
              ),
              activeIcon: Icon(
                Icons.settings,
                color: Colours.app_main,
              ),
              label: 'setting',
            ),
          ],
          currentIndex: _selectedIndex,
          onTap: (index) {
            _pageController.jumpToPage(index);
          },
        ));
  }

  @override
  void dispose() {
    super.dispose();
    /// 注销事件监听
    Utils.eventBusOff(EventBusNameEnum.LOGIN_EVENT);
    Utils.eventBusOff(EventBusNameEnum.LOGOUT_EVENT);
  }
}
