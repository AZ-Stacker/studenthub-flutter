import 'package:flutter/material.dart';
import 'package:studenthub/pages/about_page.dart';
import 'package:studenthub/pages/home_page.dart';
import 'package:studenthub/pages/programme_page.dart';
import 'package:studenthub/pages/records_page.dart';
import 'package:studenthub/pages/settings_page.dart';
import 'package:studenthub/pages/student_list_page.dart';

class MainShell extends StatefulWidget {
  const MainShell({super.key});

  @override
  State<MainShell> createState() => _MainShellState();
}

class _MainShellState extends State<MainShell> {
  int currentIndex = 0;

  static const _pages = [
    HomePage(),
    StudentListPage(),
    RecordsPage(),
    ProgrammePage(),
  ];

  void _select(int index) => setState(() => currentIndex = index);

  void _open(Widget page) {
    Navigator.pop(context);
    Navigator.push(context, MaterialPageRoute<void>(builder: (_) => page));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('StudentHub')),
      drawer: Drawer(
        child: ListView(
          children: [
            const DrawerHeader(child: Text('StudentHub')),
            ListTile(
              leading: const Icon(Icons.home),
              title: const Text('Home'),
              onTap: () {
                _select(0);
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.people),
              title: const Text('Student Information'),
              onTap: () {
                _select(1);
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.table_chart),
              title: const Text('Student Records'),
              onTap: () {
                _select(2);
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.info),
              title: const Text('About'),
              onTap: () => _open(const AboutPage()),
            ),
            ListTile(
              leading: const Icon(Icons.settings),
              title: const Text('Settings'),
              onTap: () => _open(const SettingsPage()),
            ),
          ],
        ),
      ),
      body: _pages[currentIndex],
      bottomNavigationBar: NavigationBar(
        selectedIndex: currentIndex,
        onDestinationSelected: _select,
        destinations: const [
          NavigationDestination(icon: Icon(Icons.home), label: 'Home'),
          NavigationDestination(icon: Icon(Icons.people), label: 'Students'),
          NavigationDestination(
            icon: Icon(Icons.table_chart),
            label: 'Records',
          ),
          NavigationDestination(icon: Icon(Icons.school), label: 'Programmes'),
        ],
      ),
    );
  }
}
