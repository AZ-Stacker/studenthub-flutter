class Student {
  const Student({
    required this.name,
    required this.matricNo,
    required this.programme,
    required this.email,
    required this.cgpa,
  });

  final String name;
  final String matricNo;
  final String programme;
  final String email;
  final double cgpa;
}

const List<Student> sampleStudents = [
  Student(
    name: 'Ali Tan',
    matricNo: 'S12345',
    programme: 'Software Engineering',
    email: 'ali@uni.edu.my',
    cgpa: 3.90,
  ),
  Student(
    name: 'Sara Lee',
    matricNo: 'S12346',
    programme: 'Software Engineering',
    email: 'sara@uni.edu.my',
    cgpa: 3.80,
  ),
  Student(
    name: 'John Lim',
    matricNo: 'S12347',
    programme: 'Data Science',
    email: 'john@uni.edu.my',
    cgpa: 3.70,
  ),
  Student(
    name: 'Aina Rahman',
    matricNo: 'S12348',
    programme: 'Data Science',
    email: 'aina@uni.edu.my',
    cgpa: 3.60,
  ),
  Student(
    name: 'David Ng',
    matricNo: 'S12349',
    programme: 'Cybersecurity',
    email: 'david@uni.edu.my',
    cgpa: 3.50,
  ),
  Student(
    name: 'Nurul Huda',
    matricNo: 'S12350',
    programme: 'Cybersecurity',
    email: 'nurul@uni.edu.my',
    cgpa: 3.45,
  ),
  Student(
    name: 'Kevin Wong',
    matricNo: 'S12351',
    programme: 'Software Engineering',
    email: 'kevin@uni.edu.my',
    cgpa: 3.30,
  ),
  Student(
    name: 'Farah Aziz',
    matricNo: 'S12352',
    programme: 'Data Science',
    email: 'farah@uni.edu.my',
    cgpa: 3.20,
  ),
  Student(
    name: 'Daniel Chong',
    matricNo: 'S12353',
    programme: 'Cybersecurity',
    email: 'daniel@uni.edu.my',
    cgpa: 3.10,
  ),
  Student(
    name: 'Mei Ling',
    matricNo: 'S12354',
    programme: 'Software Engineering',
    email: 'mei@uni.edu.my',
    cgpa: 3.00,
  ),
];
