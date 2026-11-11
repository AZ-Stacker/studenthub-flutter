import 'package:flutter/material.dart';
import 'package:studenthub/models/student.dart';

class StudentDetailsPage extends StatelessWidget {
  const StudentDetailsPage({super.key, required this.student});

  final Student student;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        title: const Text(
          'Student Details',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Container(
        color: const Color.fromARGB(255, 22, 44, 59),
        child: SizedBox.expand(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                const SizedBox(height: 20),

                CircleAvatar(
                  radius: 45,
                  backgroundColor: Theme.of(context)
                      .colorScheme
                      .primaryContainer,
                  child: Text(
                    student.name[0].toUpperCase(),
                    style: const TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),

                const SizedBox(height: 16),

                Text(
                  student.name,
                  style: const TextStyle(
                    fontSize: 23,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 0, 106, 255),
                  ),
                  textAlign: TextAlign.center,
                ),

                const SizedBox(height: 6),

                Text(
                  student.programme,
                  style: const TextStyle(
                    color: Color.fromARGB(179, 5, 164, 196),
                    fontSize: 15,
                  ),
                ),

                const SizedBox(height: 30),

                _buildDetailCard(
                  context,
                  'Matric Number',
                  student.matricNo,
                  Icons.badge_outlined,
                ),

                _buildDetailCard(
                  context,
                  'Email Address',
                  student.email,
                  Icons.email_outlined,
                ),

                _buildDetailCard(
                  context,
                  'Programme',
                  student.programme,
                  Icons.school_outlined,
                ),

                _buildDetailCard(
                  context,
                  'CGPA',
                  student.cgpa.toStringAsFixed(2),
                  Icons.grade_outlined,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDetailCard(
    BuildContext context,
    String title,
    String value,
    IconData icon,
  ) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        leading: Icon(icon, color: Theme.of(context).colorScheme.primary),
        title: Text(
          title,
          style: const TextStyle(fontSize: 13, color: Colors.grey),
        ),
        subtitle: SelectableText(
          value,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        ),
      ),
    );
  }
}
