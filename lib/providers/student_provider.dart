import 'package:flutter/foundation.dart';
import 'package:studenthub/models/student.dart';

class StudentProvider extends ChangeNotifier {
  final List<Student> _students = List.of(sampleStudents);

  List<Student> get students => List.unmodifiable(_students);
}
