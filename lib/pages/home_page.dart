import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:studenthub/providers/student_provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final students = context.watch<StudentProvider>().students;
    final programmes = students.map((s) => s.programme).toSet();
    final averageCgpa = students.isEmpty
        ? 0.0
        : students.map((s) => s.cgpa).reduce((a, b) => a + b) / students.length;
    final colors = Theme.of(context).colorScheme;

    return ColoredBox(
      color: const Color.fromARGB(255, 22, 44, 59),
      child: SizedBox.expand(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              const SizedBox(height: 8),
              CircleAvatar(
                radius: 48,
                backgroundColor: colors.primaryContainer,
                child: Icon(Icons.school, size: 56, color: colors.primary),
              ),
              const SizedBox(height: 16),
              Text(
                'StudentHub',
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: const Color.fromARGB(255, 0, 106, 255),
                ),
              ),
              const SizedBox(height: 4),
              Text(
                'Your Student Portal',
                style: Theme.of(context).textTheme.titleMedium
                    ?.copyWith(color: const Color.fromARGB(179, 5, 164, 196)),
              ),
              const SizedBox(height: 16),
              const Text(
                'Welcome! Browse student profiles, check academic records '
                'and explore programmes, all in one place.',
                textAlign: TextAlign.center,
                style: TextStyle(color: Color.fromARGB(223, 0, 234, 255)),
              ),
              const SizedBox(height: 24),
              Row(
                children: [
                  Expanded(
                    child: _SummaryCard(
                      icon: Icons.people,
                      value: '${students.length}',
                      label: 'Students',
                    ),
                  ),
                  Expanded(
                    child: _SummaryCard(
                      icon: Icons.menu_book,
                      value: '${programmes.length}',
                      label: 'Programmes',
                    ),
                  ),
                  Expanded(
                    child: _SummaryCard(
                      icon: Icons.star,
                      value: averageCgpa.toStringAsFixed(2),
                      label: 'Avg CGPA',
                    ),
                  ),
                ],
              ),
            ],
          ),
        ), // SingleChildScrollView
      ), // SizedBox.expand
    ); // ColoredBox
  }
}

class _SummaryCard extends StatelessWidget {
  const _SummaryCard({
    required this.icon,
    required this.value,
    required this.label,
  });

  final IconData icon;
  final String value;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16),
        child: Column(
          children: [
            Icon(icon, color: Theme.of(context).colorScheme.primary),
            const SizedBox(height: 8),
            Text(value, style: Theme.of(context).textTheme.titleLarge),
            Text(label),
          ],
        ),
      ),
    );
  }
}
