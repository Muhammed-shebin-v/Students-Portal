import 'dart:developer';

import 'package:database/db/functions/function.dart';
import 'package:database/db/models/model.dart';
import 'package:database/Screens/screenupdate.dart';
import 'package:flutter/material.dart';



class ScreenInfo extends StatefulWidget {
  final StudentModel data;
  const ScreenInfo({super.key, required this.data});


  @override
  State<ScreenInfo> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<ScreenInfo> {

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 166, 208, 244),
        title: const Text('Student Inforation'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Center(
          child: Container(
              decoration: const BoxDecoration(
                  color: Color.fromARGB(255, 164, 210, 249),
                  borderRadius: BorderRadius.all(Radius.circular(30))),
              width: double.infinity,
              height: 600,
              child: ValueListenableBuilder(
                valueListenable: studentListNotifier,
                builder: (context,List<StudentModel> studentList,_) {
                  final updatedStudent = studentList.singleWhere((student)=> student.id == widget.data.id);
                  log(updatedStudent.name);
                return Column(
                  
                  children: [
                    const SizedBox(
                      height: 70,
                    ),
                    CircleAvatar(
                      radius: 80,
                      backgroundImage: updatedStudent.image != null
                          ? MemoryImage(updatedStudent.image!)
                          : null,
                      child: updatedStudent.image == null
                          ? const Icon(Icons.person)
                          : null,
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    Text(
                      'Name: ${updatedStudent.name}',
                      style: const TextStyle(fontSize: 20),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      ' Age: ${updatedStudent.age}',
                      style: const TextStyle(fontSize: 20),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      'Batch: ${updatedStudent.address}',
                      style: const TextStyle(fontSize: 20),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      'Phone: ${updatedStudent.phone}',
                      style: const TextStyle(fontSize: 20),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      'Student code: ${updatedStudent.pin}',
                      style: const TextStyle(fontSize: 20),
                    ),
                    const SizedBox(
                      height: 60,
                    ),
                    Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Row(children: [
                          Expanded(
                            flex: 2,
                            child: SizedBox(
                                height: 40,
                                child: ElevatedButton(
                                    onPressed: () {
                                      Navigator.of(context).push(
                                          MaterialPageRoute(
                                              builder: (context) => Screenupdate(
                                                  data: updatedStudent)));
                                    },
                                    child: const Text('edit'))),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: SizedBox(
                              height: 40,
                              child: ElevatedButton(
                                onPressed: () {
                                 showDialog(context: (context), builder: (ctx1){
                                   return AlertDialog(
                                     title: const Text('Delete'),
                                     content: const Text('Do you want to delete?'),
                                     actions: [
                                       TextButton(onPressed: () async{
                                         await delete(widget.data.id!);
                                         Navigator.of(context).pop();
                                         Navigator.of(context).pop();
                                      }, child: const Text('Yes')),

                                      TextButton(onPressed: (){
                                        Navigator.of(context).pop();
                                      }, child: const Text('No'))
                                  ],
                                );
                                 }
                                 );
                                 },
                                child: const Text(
                                  'delete',
                                  style: TextStyle(color: Colors.red),
                                ),
                              ),
                            ),
                          ),
                        ]))
                  ],
                );
                }
              )),
        ),
      ),
    );
  }
}
