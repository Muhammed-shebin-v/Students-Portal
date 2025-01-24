import 'dart:developer';
import 'dart:io';
import 'dart:typed_data';

import 'package:database/db/models/model.dart';
import 'package:flutter/material.dart';
import 'package:database/db/database/function.dart';
import 'package:image_picker/image_picker.dart';

class Screenupdate extends StatefulWidget {
  const Screenupdate({super.key, required this.data});
  final StudentModel data;

  @override
  State<Screenupdate> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<Screenupdate> {
  final TextEditingController _controllername = TextEditingController();
  final TextEditingController _controllerage = TextEditingController();
  final TextEditingController _controlleraddress = TextEditingController();
  final TextEditingController _controllerphonenumber = TextEditingController();
  final TextEditingController _controllerpincode = TextEditingController();

  @override
  void initState() {
    _controllername.text = widget.data.name;
    _controllerage.text = widget.data.age;
    _controlleraddress.text = widget.data.address;
    _controllerphonenumber.text = widget.data.phone;
    _controllerpincode.text = widget.data.pin;
    super.initState();
  }

  File? _selectImage;
  Uint8List? _imageBytes;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            'Edit Student Details',
            style: TextStyle(fontFamily: AutofillHints.email),
          ),
        ),
        body: SingleChildScrollView(
          child: Form(
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
                        showDialog(
                            context: context,
                            builder: (ctx) {
                              return AlertDialog(
                                title: const Text('Edit profile picture'),
                                shadowColor: Colors.black,
                                actions: [
                                  TextButton(
                                      onPressed: () {
                                        deleteImage(widget.data.id!);
                                        // Navigator.of(context).pop();
                                      },
                                      child: const Text('Remove profile')),
                                  TextButton(
                                      onPressed: () {
                                        pickImageFromGallery();
                                      },
                                      child: const Text('Choose photo'))
                                ],
                              );
                            });
                      },
                      child: CircleAvatar(
                          radius: 70,
                          backgroundColor:
                              const Color.fromARGB(255, 179, 218, 250),
                          backgroundImage: widget.data.image != null
                              ? MemoryImage(widget.data.image!)
                              : null,
                          child: _selectImage != null
                              ? ClipOval(
                                  child: Image.file(
                                    _selectImage!,
                                    height: 140,
                                    width: 140,
                                    fit: BoxFit.cover,
                                  ),
                                )
                              : const Text('')),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      textCapitalization: TextCapitalization.words,
                      controller: _controllername,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15.0)),
                          labelText: widget.data.name),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                        controller: _controllerage,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15.0)),
                          labelText: widget.data.age,
                        )),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                        textCapitalization: TextCapitalization.characters,
                        controller: _controlleraddress,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15.0)),
                            labelText: widget.data.address)),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                        controller: _controllerphonenumber,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15.0)),
                            labelText: widget.data.phone)),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      controller: _controllerpincode,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15.0)),
                          labelText: widget.data.pin),
                    ),
                    const SizedBox(
                      height: 50,
                    ),
                    ElevatedButton.icon(
                      onPressed: () {
                        updateData();
                        getdata();
                        Navigator.of(context).pop();
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

  Future<void> updateData() async {
    try {
      final name = _controllername.text.trim();
      final age = _controllerage.text.trim();
      final address = _controlleraddress.text.trim();
      final phone = _controllerphonenumber.text.trim();
      final pin = _controllerpincode.text.trim();

      if (_selectImage != null) {
        _imageBytes = await _selectImage!.readAsBytes();
      } else if (_imageBytes == null && widget.data.image != null) {
        _imageBytes = widget.data.image;
      }

      final data = StudentModel(
          name: name,
          age: age,
          address: address,
          phone: phone,
          pin: pin,
          image: _imageBytes,
          id: widget.data.id);
      await update(data);
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
