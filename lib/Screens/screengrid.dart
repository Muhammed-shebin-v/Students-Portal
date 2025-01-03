

import 'package:database/db/functions/function.dart';
import 'package:database/Screens/info.dart';
import 'package:database/db/models/model.dart';
import 'package:flutter/material.dart';



class screengrid extends StatefulWidget {
  const screengrid({super.key});

  @override
  State<screengrid> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<screengrid> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: ValueListenableBuilder(
          valueListenable: studentListNotifier,
          builder: (conte, List<StudentModel> studentsList, Widget? child) {
            return GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 40,
                mainAxisSpacing: 30,
                childAspectRatio: 1,
              ),
              itemBuilder: (BuildContext context, int index) {
                final value = studentsList[index];
                return GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => screeninfo(data: value),
                      ),
                    );
                  },
                  child: Container(
                    decoration: const BoxDecoration(
                        color: Color.fromARGB(255, 153, 206, 250),
                        borderRadius: BorderRadius.all(Radius.circular(20))),
                    child: Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Padding(
                          padding: const EdgeInsets.only(top: 10),
                          child: Column(
                            children: [
                              CircleAvatar(
                                radius: 35,
                                backgroundImage: value.image != null
                                    ? MemoryImage(value.image!)
                                    : null,
                                child: value.image == null
                                    ? const Icon(Icons.person)
                                    : null,
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Text(value.name),
                              Align(
                                alignment: Alignment.bottomRight,
                                child: IconButton(
                                  onPressed: () {
                                    showDialog(
                                        context: (context),
                                        builder: (ctx1) {
                                          return AlertDialog(
                                            title: const Text('Delete'),
                                            content:
                                                const Text('Do you want to delete?'),
                                            actions: [
                                              TextButton(
                                                  onPressed: () {
                                                    delete(value.id!);
                                                    Navigator.of(context).pop();
                                                  },
                                                  child: const Text('Yes')),
                                              TextButton(
                                                  onPressed: () {
                                                    Navigator.of(context).pop();
                                                  },
                                                  child: const Text('No'))
                                            ],
                                          );
                                        });
                                  },
                                  icon: const Icon(Icons.delete),
                                  style: ButtonStyle(
                                      foregroundColor:
                                          MaterialStateProperty.all(
                                              const Color.fromARGB(
                                                  255, 238, 88, 78))),
                                ),
                              )
                            ],
                          )),
                    ),
                  ),
                );
              },
              itemCount: studentsList.length,
            );
          },
        ),
      ),
    );
  }
}
