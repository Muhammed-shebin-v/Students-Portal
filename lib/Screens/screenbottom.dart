
import 'package:database/Screens/info.dart';
import 'package:database/db/functions/function.dart';

import 'package:database/Screens/screenadd.dart';
import 'package:database/Screens/screengrid.dart';
import 'package:database/Screens/screenlist.dart';
import 'package:flutter/material.dart';
import 'package:database/db/models/model.dart';


class Bottom extends StatefulWidget {
  const Bottom({super.key});

  @override
  State<Bottom> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<Bottom> {
  List<Map<String, dynamic>> _searchResults = [];
  final TextEditingController _searchController = TextEditingController();

   


  
  int _current = 0;
  final pages = [const Screenlist(), const screengrid()];
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 154, 206, 248),
        title: const Text('Student Portal'),
        centerTitle: true,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
              onPressed: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => const addstudent()));
              },
              icon: const Icon(Icons.add)),
          IconButton(
              onPressed: () {
                showbottom();
              },
              icon: const Icon(Icons.search))
        ],
      ),


      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: const Color.fromARGB(255, 168, 211, 246),
        currentIndex: _current,
        onTap: (newindex) {
          setState(() {
            _current = newindex;
          });
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.list), label: 'list'),
          BottomNavigationBarItem(icon: Icon(Icons.grid_3x3), label: 'grid'),
         
        ],
      ),
      body: pages[_current],
    );
  }

  void showbottom() async {
    return showModalBottomSheet(
      showDragHandle: true,
      context: context,
      builder: (ctx) => Padding(
        padding: const EdgeInsets.all(10.0),
        child: Container(
          width: double.infinity,
          height: 500,
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(30)),
          child: Column(

            children:[ 
              TextField(
              controller: _searchController,
              
              decoration: InputDecoration(
                
                             
                
                  labelText: 'Search',
                  border:  OutlineInputBorder( borderRadius: BorderRadius.circular(15.0)),
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.search),
                    onPressed: () {
                      _performSearch(_searchController.text);
                     
                    },
                  )
                  ),
            
              onSubmitted: (query) {
                   _performSearch(query);
                },
            ),
             Expanded(

            child: ValueListenableBuilder(
              valueListenable: studentListNotifier,
              builder: (context, List<StudentModel> studentsList, child) {
                
               return ListView.builder(
                itemCount: _searchResults.length,
                itemBuilder: (context, ind) {
               
                  final searchResult=_searchResults[ind];
                  final studentId=searchResult['id'];
                  final student = studentsList.firstWhere((student)=>student.id==studentId);
                  
                  return ListTile(

                    leading: CircleAvatar(
                      backgroundImage: student.image!= null
                              ? MemoryImage(student.image!)
                              : null,
                          child: student.image == null
                              ? const Icon(Icons.person)
                              : null,
                      ),
                    title: Text(student.name),
                    subtitle: Text('Age: ${student.age}'),
                    trailing: IconButton(onPressed: (){
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
                                   delete(student.id!);
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
                     icon: const Icon(Icons.delete)),
                    onTap:(){ Navigator.of(context).push(MaterialPageRoute(builder: (context)=>screeninfo(data: student)));}
                  );
                },
              );
              }
            ),
          ),

            ]
          ),
        ),
      ),
    );
  }
  void _performSearch(String query) async {
    final results = await searchStudents(query);
    setState(() {
      _searchResults = results;
    });
  }
}
