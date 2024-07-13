// import 'package:postgres/postgres.dart';

// class DatabaseHelper {
//   static Future<List<Map<String, dynamic>>> getStudents() async {
//     final connection = PostgreSQLConnection(
//       'your_host', // Thay bằng địa chỉ host của bạn
//       5432, // Port mặc định của PostgreSQL
//       'lop_hoc', // Tên database
//       username: 'your_username', // Thay bằng username của bạn
//       password: 'your_password', // Thay bằng password của bạn
//     );

//     await connection.open();

//     List<List<dynamic>> results = await connection.query('SELECT * FROM hoc_sinh');
//     await connection.close();

//     return results.map((row) => {
//       'id': row[0],
//       'ten': row[1],
//       'tuoi': row[2],
//     }).toList();
//   }
// }