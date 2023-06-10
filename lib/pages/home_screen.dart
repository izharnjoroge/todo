import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:tasks/data/db_tasks.dart';
import 'package:tasks/pages/task_lists.dart';

import '../utils/dialogue.dart';

class MyTasks extends StatefulWidget {
  const MyTasks({super.key});

  @override
  State<MyTasks> createState() => _MyTasksState();
}

class _MyTasksState extends State<MyTasks> {
  final _myBox = Hive.box("mybox");
  TasksDb db = TasksDb();
  @override
  void initState() {
    //default tasks

    if (_myBox.get("taskList") == null) {
      db.createFirstTask();
    } else {
      db.loadTask();
    }

    super.initState();
  }

  final _controller = TextEditingController();

  void checkBoxIndicator(bool? value, int index) {
    setState(() {
      db.taskList[index][1] = !db.taskList[index][1];
    });
    db.updateDb();
  }

  void saveNewTask() {
    if (_controller.text.isEmpty) {
      // _controller has no value, so pop the context
      Navigator.of(context).pop();
      return;
    }

    setState(() {
      db.taskList.add([_controller.text, false]);
      _controller.clear();
    });
    Navigator.of(context).pop();
    db.updateDb();
  }

  void createNewTask() {
    showDialog(
        context: context,
        builder: (context) {
          return Dialogue(
            controller: _controller,
            onSave: saveNewTask,
            onCancel: () => Navigator.of(context).pop(),
          );
        });
  }

  void delete(int index) {
    setState(() {
      db.taskList.removeAt(index);
    });
    db.updateDb();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: const Text("TO-DO"),
          titleTextStyle:
              const TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
          centerTitle: true,
          toolbarHeight: 60.2,
          toolbarOpacity: 0.8,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(25),
                bottomLeft: Radius.circular(25)),
          ),
          elevation: 0.00,
          backgroundColor: const Color.fromARGB(255, 82, 219, 89),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: createNewTask,
          child: const Icon(Icons.add),
        ),
        body: ListView.builder(
          itemCount: db.taskList.length,
          itemBuilder: (context, index) {
            return TaskLists(
              taskName: db.taskList[index][0],
              taskCompleted: db.taskList[index][1],
              onChanged: (value) => checkBoxIndicator(value, index),
              deleteTask: (BuildContext context) => delete(index),
            );
          },
        ),
      ),
    );
  }
}
