import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:studenthub/pages/main_shell.dart';
import 'package:studenthub/providers/student_provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => StudentProvider(),
      child: const StudentHubApp(),
    ),
  );
}

class StudentHubApp extends StatelessWidget {
  const StudentHubApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'StudentHub',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const MainShell(),
    );
  }
}
