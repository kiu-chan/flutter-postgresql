import 'package:http/http.dart' as http;
import 'dart:convert';

Future<List<Student>> fetchStudents() async {
  final response = await http.get(Uri.parse('http://your-api-server/students'));
  
  if (response.statusCode == 200) {
    Iterable data = json.decode(response.body);
    return data.map((json) => Student.fromJson(json)).toList();
  } else {
    throw Exception('Failed to load students');
  }
}

class Student {
  final int id;
  final String name;
  final int age;
  final String grade;

  Student({required this.id, required this.name, required this.age, required this.grade});

  factory Student.fromJson(Map<String, dynamic> json) {
    return Student(
      id: json['id'],
      name: json['name'],
      age: json['age'],
      grade: json['grade'],
    );
  }
}
