import 'dart:developer';
import 'dart:io';

import 'package:database/db/database/function.dart';
import 'package:database/db/models/model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AddStudent extends StatefulWidget {
  const AddStudent({super.key});

  @override
  State<AddStudent> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<AddStudent> {
  final TextEditingController _controllername = TextEditingController();
  final TextEditingController _controllerage = TextEditingController();
  final TextEditingController _controlleraddress = TextEditingController();
  final TextEditingController _controllerphonenumber = TextEditingController();
  final TextEditingController _controllerpincode = TextEditingController();

  final formkey = GlobalKey<FormState>();
  File? _selectImage;
  Uint8List? _imageBytes;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            'Add New Student',
            style: TextStyle(fontFamily: AutofillHints.email),
          ),
        ),
        body: SingleChildScrollView(
          child: Form(
            key: formkey,
            child: Padding(
              padding: const EdgeInsets.all(25.0),
              child: Padding(
                padding: const EdgeInsets.only(
                  top: 15,
                ),
                child: Column(
                  children: [
                    InkWell(
                      onTap: () {
                        pickImageFromGallery();
                      },
                      child: CircleAvatar(
                          backgroundColor:
                              const Color.fromARGB(255, 165, 211, 249),
                          radius: 70,
                          child: _selectImage != null
                              ? ClipOval(
                                  child: Image.file(
                                    _selectImage!,
                                    height: 140,
                                    width: 140,
                                    fit: BoxFit.cover,
                                  ),
                                )
                              : const Text('Select image')),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      controller: _controllername,
                      textCapitalization: TextCapitalization.words,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15.0)),
                          labelText: 'Student Name'),
                      validator: (value) {
                        if (value == null ||
                            value.isEmpty ||
                            value.length < 3 ||
                            num.tryParse(value) != null) {
                          return 'Enter Name';
                        }
                        return null;
                      },
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                        keyboardType: TextInputType.number,
                        validator: (value) {
                          if (value == null ||
                              value.isEmpty ||
                              num.tryParse(value) == null) {
                            return ' enter age';
                          }
                          return null;
                        },
                        maxLength: 2,
                        controller: _controllerage,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15.0)),
                          labelText: 'Age',
                        )),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                        textCapitalization: TextCapitalization.characters,
                        validator: (value) {
                          if (value == null ||
                              value.isEmpty ||
                              num.tryParse(value) != null) {
                            return 'enter Batch';
                          }
                          return null;
                        },
                        controller: _controlleraddress,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15.0)),
                            labelText: 'Batch')),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      keyboardType: TextInputType.phone,
                      maxLength: 10,
                      controller: _controllerphonenumber,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15.0)),
                          labelText: 'Phone Number'),
                      validator: (value) {
                        if (value == null ||
                            value.isEmpty ||
                            num.tryParse(value) == null) {
                          return 'enter number';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      keyboardType: TextInputType.number,
                      maxLength: 6,
                      controller: _controllerpincode,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15.0)),
                          labelText: 'Student code'),
                      validator: (value) {
                        if (value == null ||
                            value.isEmpty ||
                            num.tryParse(value) == null) {
                          return 'enter Student code';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    ElevatedButton.icon(
                      onPressed: () {
                        if (formkey.currentState!.validate()) {
                          checkdata();
                        }
                      },
                      label: const Text('Save'),
                    )
                  ],
                ),
              ),
            ),
          ),
        ));
  }

  Future<void> checkdata() async {
    try {
      final name = _controllername.text.trim();
      final age = _controllerage.text.trim();
      final address = _controlleraddress.text.trim();
      final phonenumber = _controllerphonenumber.text.trim();
      final pincode = _controllerpincode.text.trim();

      if (_selectImage != null) {
        _imageBytes = await _selectImage!.readAsBytes();
      }

      final _students = StudentModel(
          image: _imageBytes,
          name: name,
          age: age,
          address: address,
          phone: phonenumber,
          pin: pincode);

      insertData(_students);
      Navigator.of(context).pop();
      await getdata();
    } catch (e) {
      log('`error$e');
    }
  }

  Future<void> pickImageFromGallery() async {
    final returnImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (returnImage != null) {
      setState(() {
        _selectImage = File(returnImage.path);
      });
    }
  }
}
