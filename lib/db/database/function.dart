import 'package:database/db/models/model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';


ValueNotifier<List<StudentModel>> studentListNotifier = ValueNotifier([]);
late Database _db;

Future<void>initializeDataBase()async{
  _db=await openDatabase('students',version: 1,
  onCreate: (db, version)async{
  await db.execute('''
CREATE TABLE student(
id INTEGER PRIMARY KEY AUTOINCREMENT,
name TEXT,
age TEXT,
address TEXT,
phone TEXT,
pin TEXT,
image BLOB
)''');
  },
  );
}


insertData(StudentModel value)async{
  await _db.rawInsert('''
INSERT INTO student(
name,age,address,phone,pin,image)
VALUES(?,?,?,?,?,?)''',
[
 value.name,
 value.age,
 value.address,
 value.phone,
 value.pin,
 value.image
]
);
}
Future<void>getdata()async{
  final _values=await _db.rawQuery('SELECT * FROM student');
  studentListNotifier.value.clear();
  _values.forEach((map){
    final student=StudentModel.fromMap(map);
    studentListNotifier.value.add(student);
  });
    studentListNotifier.notifyListeners();
}

Future<void>delete(int id)async{
  await _db.rawDelete('DELETE FROM student WHERE id = ?',[id]);
  await getdata();
  studentListNotifier.notifyListeners();
}

Future<void> deleteImage(int id) async {
  await _db.rawUpdate(
    'UPDATE student SET image = NULL WHERE id = ?', [id]
  );
  await getdata();
  studentListNotifier.notifyListeners();
}
Future<void>update(StudentModel data) async{
  await _db.rawUpdate('UPDATE student SET name=?,age=?,address=?,phone=?,pin=?,image=?WHERE id=?',
  [
  data.name,
  data.age,
  data.address,
  data.phone,
  data.pin,
  data.image,
  data.id
  ]);
  getdata();
  studentListNotifier.notifyListeners();
}

Future<List<Map<String, dynamic>>> searchStudents(String query) async {
    List<Map<String, dynamic>> results = await _db.query(
      'student',
      where: 'name LIKE ? OR age LIKE ? OR address LIKE ? OR phone LIKE ? OR pin LIKE ?',
      whereArgs: ['%$query%', '%$query%', '%$query%', '%$query%', '%$query%'],
    );
    return results;
  }
  

