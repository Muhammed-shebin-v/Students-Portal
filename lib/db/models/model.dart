import 'dart:typed_data';

class StudentModel {
  int? id;

  final String name;

  final String age;

  final String address;

  final String phone;

  final String pin;

  Uint8List? image;

  StudentModel( 
      {
      required this.name,
      required this.age,
      required this.address,
      required this.phone,
      required this.pin,
      this.id,
      this.image
      }
    );

  static StudentModel fromMap(Map<String, dynamic> map) {
    return StudentModel(
        id: map['id'],
        name: map['name'],
        age: map['age'],
        address: map['address'],
        phone: map['phone'],
        pin: map['pin'],
        image: map['image']);
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'age': age,
      'address': address,
      'phone': phone,
      'pin': pin,
      'image': image
    };
  }
}
