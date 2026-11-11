import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:studenthub/pages/student_details_page.dart';
import 'package:studenthub/providers/student_provider.dart';

class StudentListPage extends StatefulWidget {
  const StudentListPage({super.key});

  @override
  State<StudentListPage> createState() => _StudentListPageState();
}

class _StudentListPageState extends State<StudentListPage> {
  String _searchQuery = '';

  @override
  Widget build(BuildContext context) {
    final students = context.watch<StudentProvider>().students;

    final filteredStudents = students.where((student) {
      final query = _searchQuery.toLowerCase();

      return student.name.toLowerCase().contains(query) ||
          student.matricNo.toLowerCase().contains(query) ||
          student.programme.toLowerCase().contains(query);
    }).toList();

    return SafeArea(
      child: Container(
        color: const Color.fromARGB(255, 22, 44, 59),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Student Information',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 0, 106, 255),
                ),
              ),
              const SizedBox(height: 6),
              Text(
                'View and manage student information.',
                style: TextStyle(color: Colors.grey.shade600),
              ),
              const SizedBox(height: 20),

              // Search bar
              TextField(
                onChanged: (value) {
                  setState(() {
                    _searchQuery = value;
                  });
                },
                decoration: InputDecoration(
                  hintText: 'Search by name, matric or programme',
                  prefixIcon: const Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  filled: true,
                  fillColor: Colors.grey.shade100,
                ),
              ),

              const SizedBox(height: 16),

              // Student count
              Text(
                '${filteredStudents.length} Students Found',
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 15,
                ),
              ),

              const SizedBox(height: 10),

              // Student list
              Expanded(
                child: filteredStudents.isEmpty
                    ? const Center(child: Text('No students found.'))
                    : ListView.separated(
                        itemCount: filteredStudents.length,
                        separatorBuilder: (context, index) =>
                            const SizedBox(height: 8),
                        itemBuilder: (context, index) {
                          final student = filteredStudents[index];

                          return Card(
                            elevation: 1,
                            child: ListTile(
                              contentPadding: const EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 8,
                              ),
                              leading: CircleAvatar(
                                backgroundColor: Theme.of(context)
                                    .colorScheme
                                    .primaryContainer,
                                child: Text(
                                  student.name[0].toUpperCase(),
                                  style: TextStyle(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onPrimaryContainer,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              title: Text(
                                student.name,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const SizedBox(height: 4),
                                  Text('Matric: ${student.matricNo}'),
                                  Text(student.programme),
                                ],
                              ),
                              trailing: const Icon(Icons.chevron_right),
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute<void>(
                                    builder: (context) =>
                                        StudentDetailsPage(student: student),
                                  ),
                                );
                              },
                            ),
                          );
                        },
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
