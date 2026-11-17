import 'package:flutter/material.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('About'),
      ),
      body: ListView(
        children: [
          SizedBox(
            height: 240,
            child: Stack(
              alignment: Alignment.topCenter,
              children: [
                Container(
                  height: 190,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        scheme.primary,
                        scheme.tertiary,
                      ],
                    ),
                  ),
                ),
                Positioned(
                  top: 40,
                  child: Text(
                    'StudentHub',
                    style: theme.textTheme.headlineMedium?.copyWith(
                      color: scheme.onPrimary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Positioned(
                  bottom: 0,
                  child: CircleAvatar(
                    radius: 50,
                    backgroundColor: scheme.surface,
                    child: CircleAvatar(
                      radius: 44,
                      backgroundColor: scheme.primaryContainer,
                      child: Icon(
                        Icons.school,
                        size: 44,
                        color: scheme.onPrimaryContainer,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          Center(
            child: Text(
              'Student Management Application',
              style: theme.textTheme.titleMedium,
            ),
          ),
          const Center(
            child: Text('Version 1.0.0'),
          ),
          const SizedBox(height: 16),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Card(
              child: ListTile(
                leading: Icon(Icons.menu_book_outlined),
                title: Text('TMA3084 – Software Engineering Laboratory'),
                subtitle: Text(
                  'Lab Exercise 5.1: Flutter widgets and Provider',
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}