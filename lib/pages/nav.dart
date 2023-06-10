import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:tasks/pages/global_task.dart';
import 'home_screen.dart';
import 'log_out.dart';

class NavigationPage extends StatefulWidget {
  const NavigationPage({super.key});

  @override
  State<NavigationPage> createState() => _NavigationPageState();
}

class _NavigationPageState extends State<NavigationPage> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    const MyTasks(),
    const GlobalTasks(),
    const LogOut(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: Container(
        color: Colors.green,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
          child: GNav(
              selectedIndex: _selectedIndex,
              onTabChange: (index) {
                setState(() {
                  _selectedIndex = index;
                });
              },
              gap: 8,
              activeColor: Colors.white,
              tabBackgroundColor:
                  Color.fromARGB(255, 226, 214, 214).withOpacity(0.5),
              backgroundColor: Colors.green,
              color: Colors.white,
              padding: const EdgeInsets.all(12),
              tabs: const [
                GButton(
                  icon: Icons.home,
                  text: "Home",
                ),
                GButton(
                  icon: Icons.info_outline_rounded,
                  text: "Global",
                ),
                GButton(
                  icon: Icons.exit_to_app,
                  text: "Log Out",
                ),
              ]),
        ),
      ),
    );
  }
}
