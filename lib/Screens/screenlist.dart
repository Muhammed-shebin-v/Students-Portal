import 'package:database/db/functions/function.dart';
import 'package:database/Screens/info.dart';
import 'package:flutter/material.dart';
import 'package:database/db/models/model.dart';

class Screenlist extends StatefulWidget {
  const Screenlist({super.key});

  @override
  State<Screenlist> createState() => _ScreenlistState();
}

class _ScreenlistState extends State<Screenlist> {
  @override
  Widget build(BuildContext context) {
    getdata();
    return Scaffold(
      body: SafeArea(
        child: ValueListenableBuilder(
        valueListenable: studentListNotifier,
        builder: (context, List<StudentModel> studentsList, Widget? child) {
          
          return Padding(
            padding: const EdgeInsets.only(top: 10.0),
            child: ListView.builder(
                itemBuilder: (ctx, index) {
                  //taking data from studentmodel
                  final data = studentsList[index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 6),
                    child: Card(
                      color: const Color.fromARGB(255, 174, 215, 247),
                      child: ListTile(
                        onTap: () {
                          // sending data to next page
                          Navigator.of(ctx).push(MaterialPageRoute(
                              builder: (ctx) => screeninfo(
                                    data: data,
                                  )));
                        },
                        title: Text(data.name),
                        leading: CircleAvatar(
                          backgroundImage: data.image != null
                              ? MemoryImage(data.image!)
                              : null,
                          child: data.image == null
                              ? const Icon(Icons.person)
                              : null,
                        ),
                        trailing: ElevatedButton(
                            style: ButtonStyle(
                                foregroundColor: WidgetStateProperty.all(
                                    const Color.fromARGB(255, 238, 88, 78))),
                            onPressed: () {
                               showDialog(context: (context), builder: (ctx1){
                               return AlertDialog(
                                title: const Text('Delete'),
                                content: const Text('Do you want to delete?'),
                                actions: [
                                  TextButton(onPressed: (){
                                    delete(data.id!);
                                    Navigator.of(context).pop();
                                  }, child: const Text('Yes')),
                                  TextButton(onPressed: (){
                                    Navigator.of(ctx1).pop();
                                  }, child: const Text('No'))
                                ],
                              );
                               }
                               );
                               }, 
                           child: const Icon(
                              Icons.delete,
                            )
                            ),
                      ),
                    ),
                  );
                },
                itemCount:studentsList.length),
          );
        },
      )),
    );
  }
}
