import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:studenthub/pages/about_page.dart';
import 'package:studenthub/pages/home_page.dart';
import 'package:studenthub/pages/programme_page.dart';
import 'package:studenthub/pages/records_page.dart';
import 'package:studenthub/pages/settings_page.dart';
import 'package:studenthub/pages/student_list_page.dart';
import 'package:studenthub/providers/navigation_provider.dart';

class MainShell extends StatelessWidget {
  const MainShell({super.key});

  static const _pages = [
    HomePage(),
    StudentListPage(),
    RecordsPage(),
    ProgrammePage(),
  ];

  void _select(BuildContext context, int index) =>
      context.read<NavigationProvider>().select(index);

  void _selectAndClose(BuildContext context, int index) {
    _select(context, index);
    Navigator.pop(context);
  }

  void _open(BuildContext context, Widget page) {
    Navigator.pop(context);
    Navigator.push(context, MaterialPageRoute<void>(builder: (_) => page));
  }

  @override
  Widget build(BuildContext context) {
    final currentIndex = context.select<NavigationProvider, int>(
      (nav) => nav.currentIndex,
    );

    return Scaffold(
      appBar: AppBar(title: const Text('StudentHub')),
      drawer: Drawer(
        child: ListView(
          children: [
            const DrawerHeader(child: Text('StudentHub')),
            ListTile(
              leading: const Icon(Icons.home),
              title: const Text('Home'),
              onTap: () => _selectAndClose(context, 0),
            ),
            ListTile(
              leading: const Icon(Icons.people),
              title: const Text('Student Information'),
              onTap: () => _selectAndClose(context, 1),
            ),
            ListTile(
              leading: const Icon(Icons.table_chart),
              title: const Text('Records'),
              onTap: () => _selectAndClose(context, 2),
            ),
            ListTile(
              leading: const Icon(Icons.school),
              title: const Text('Programmes'),
              onTap: () => _selectAndClose(context, 3),
            ),
            ListTile(
              leading: const Icon(Icons.info),
              title: const Text('About'),
              onTap: () => _open(context, const AboutPage()),
            ),
            ListTile(
              leading: const Icon(Icons.settings),
              title: const Text('Settings'),
              onTap: () => _open(context, const SettingsPage()),
            ),
          ],
        ),
      ),
      body: _pages[currentIndex],
      bottomNavigationBar: NavigationBar(
        selectedIndex: currentIndex,
        onDestinationSelected: (index) => _select(context, index),
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
