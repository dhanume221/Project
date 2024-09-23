import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:taskmanagement/profile.dart';
import 'package:taskmanagement/splash.dart';
import 'package:taskmanagement/taskfunction.dart';
import 'package:taskmanagement/Function.dart';

class Firstpage extends StatefulWidget {
  const Firstpage({super.key});

  @override
  State<Firstpage> createState() => _FirstpageState();
}

class _FirstpageState extends State<Firstpage> {
final TaskProvider _taskProvider = TaskProvider();
List<Task> _tasks = [];

@override
  void initState() {
    super.initState();
    _loadTasks();
  }

  Future<void> _loadTasks() async {
    final tasks = await _taskProvider.getTasks();
    setState(() {
      _tasks = tasks;
    });
  }

   void _addTask() async {
    final title = await _showTaskDialog(currentTitle: '1');
    if (title != null) {
      await _taskProvider.addTask(Task(title: title));
      _loadTasks();
    }
  }

   void _editTask(int index) async {
    final title = await _showTaskDialog(currentTitle: _tasks[index].title);
    if (title != null) {
      await _taskProvider.editTask(index, Task(title: title, isCompleted: _tasks[index].isCompleted));
      _loadTasks();
    }
  }

  Future <String?> _showTaskDialog ({required String currentTitle})async{
    String? title;
     return showDialog<String>(
      context: context,
      builder: (context){
        return AlertDialog(
          backgroundColor: Color.fromARGB(255, 73, 246, 214),
          // ignore: unnecessary_null_comparison
          title: Text(currentTitle == "1" ? 'Add Task' : 'Edit Task'),
          content: TextField(
            onChanged: (value){
              title=value;
            },
            decoration: const InputDecoration(hintText: 'Task Title'),
              // ignore: unnecessary_null_comparison
              controller: currentTitle == "1" ? null:TextEditingController(text: currentTitle),
          ),
           actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(title);
              },
              child: const Text('Save'),
            ),
          ],
        );
      }
     );
  }
  void _deleteTask(int index) async {
    await _taskProvider.deleteTask(index);
    _loadTasks();
  }
  @override
  Widget build(BuildContext context) {
    return 
    //  MaterialApp(
    //   debugShowCheckedModeBanner: false,
    //   home:
      Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(title: const Text("TASK MANAGEMENT SYSTEM", 
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 24,
          color: Color.fromARGB(255, 4, 19, 94)
        ),),
         backgroundColor: Color.fromARGB(255, 248, 180, 9),
          elevation: 10,
          centerTitle: true,
          

          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(10),
            ),
          ),

          actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: _addTask,
          ),
        ],
        ),
        drawer: Drawer(
          backgroundColor: Color.fromARGB(255, 78, 77, 72),
      child: ListView(children: [
        ListTile(
          title:const Text("Profile"),
          textColor: Color.fromARGB(255, 243, 242, 241),
          onTap: () {
               Navigator.push(context, MaterialPageRoute(builder: (context) => ProfilePage(),));

          },
        ),
         ListTile(
          title:const Text("Logout"),
          textColor: Color.fromARGB(255, 243, 242, 241),
          onTap: () {
            
            storingDatatoPreff(false);
            Navigator.push(context, MaterialPageRoute(builder: (context) => SplashScreen(),));

            },
        )
      ],),
    ),
      
        body: Stack(
          children:<Widget> [
             Container(
              width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('asset/graph.jpg'),
              fit: BoxFit.cover,
            ),
          ),
        ),

        BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
          child: Container(
            color: Colors.white.withOpacity(0.5),
          ),
        ),


           ListView.builder(
           itemCount: _tasks.length,
           itemBuilder: (context, index) {
          return ListTile(
            title: Text(_tasks[index].title),
            trailing: IconButton(
              icon: const Icon(Icons.delete),
              onPressed: () => _deleteTask(index),
            ),
            onTap: () => _editTask(index),
          );
        },
        ),
      // ),
          ]
        )
    );
  }
}