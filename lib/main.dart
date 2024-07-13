import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  List<dynamic> students = []; // List to store student data

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    final response = await http.get(Uri.parse('http://192.168.1.20:3000/students'));

    if (response.statusCode == 200) {
      setState(() {
        students = jsonDecode(response.body);
      });
    } else {
      throw Exception('Failed to load data');
    }
  }

    Future<void> updateData() async {
    try {
      // Dữ liệu để gửi lên server
      Map<String, dynamic> data = {
        'id': 5, // ID của bản ghi cần cập nhật
        // 'name': 'Updated Name',
        // 'age': 20,
        // 'grade': '10A',
      };

      // Gửi request POST đến API của bạn
      final response = await http.post(
      Uri.parse('http://192.168.1.20:3000/new-student'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
    },
  body: jsonEncode(data),
);


      // Kiểm tra và xử lý kết quả từ server
      if (response.statusCode == 200) {
        print('Update successful');
      } else {
        print('Failed to update data');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

    Future<void> deleteData() async {
    try {
      // Dữ liệu để gửi lên server
      Map<String, dynamic> data = {
        'id': 7, // ID của bản ghi cần cập nhật
      };

      // Gửi request POST đến API của bạn
      final response = await http.delete(
      Uri.parse('http://192.168.1.20:3000/delete-student'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
    },
  body: jsonEncode(data),
);


      // Kiểm tra và xử lý kết quả từ server
      if (response.statusCode == 200) {
        print('Update successful');
      } else {
        print('Failed to update data');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Student List'),
        ),
        body: Column(
          children: [
            Container(
              height: 600,
              child: ListView.builder(
                itemCount: students.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(students[index]['name']),
                    subtitle: Text('Age: ${students[index]['age']}, Grade: ${students[index]['grade']}'),
                  );
                },
              ),
            ),
            ElevatedButton(
            onPressed: () {
              updateData();
            },
            child: Text('Update Data'),
          ),
            ElevatedButton(
            onPressed: () {
              deleteData();
            },
            child: Text('Delete Data'),
          ),
          ],
        ),
      ),
    );
  }
}


