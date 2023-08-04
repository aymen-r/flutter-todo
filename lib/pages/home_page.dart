import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:todo/data/database.dart';
import 'package:todo/utilities/dialog_box.dart';
import 'package:todo/utilities/tood_tile.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // reference the hive box
  final myTodoBox = Hive.box('todoBox');

  ToDoDataBase db = ToDoDataBase();

  @override
  void initState() {
    // first time open the app, create default data
    if (myTodoBox.get('TODOLIST') == null) {
      db.createInitialData();
    } else {
      db.loadData();
    }

    super.initState();
  }

  // text controller
  final myController = TextEditingController();

  // change checkBox
  void checkBoxChange(bool? value, int index) {
    setState(() {
      db.todoList[index][1] = !db.todoList[index][1];
    });
    db.updateData();
  }

  // saveNewTask
  void saveNewTask() {
    if (myController.text != '') {
      setState(() {
        db.todoList.add([myController.text, false]);
        myController.clear();
      });
      Navigator.of(context).pop();
    }
    db.updateData();
  }

  // create new task
  void createNewTask() {
    showDialog(
        context: context,
        builder: (ctx) {
          return DialogBox(
            controller: myController,
            onSave: saveNewTask,
            onCancel: () => Navigator.of(context).pop(),
          );
        });
  }

  // delete Task
  void deleteTask(int index) {
    setState(() {
      db.todoList.removeAt(index);
    });
    db.updateData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          toolbarHeight: 70,
          centerTitle: true,
          title: const Text(
            'TO DO',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          elevation: 0,
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            return createNewTask();
          },
          elevation: 15,
          child: const Icon(Icons.add),
        ),
        body: ListView.builder(
          itemCount: db.todoList.length,
          itemBuilder: (context, index) {
            return ToDoTile(
              taskName: db.todoList[index][0],
              taskCompleted: db.todoList[index][1],
              onChanged: (value) => checkBoxChange(value, index),
              deleteTask: (context) => deleteTask(index),
            );
          },
        ));
  }
}
