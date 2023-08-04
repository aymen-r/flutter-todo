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
      backgroundColor: Colors.deepPurple[200],
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          return createNewTask();
        },
        elevation: 15,
        child: const Icon(Icons.add),
      ),
      body: Padding(
        padding: const EdgeInsets.only(bottom: 25),
        child: CustomScrollView(
          slivers: [
            const SliverAppBar(
              // leading: const Icon(Icons.menu),
              expandedHeight: 200,
              pinned: true,
              flexibleSpace: FlexibleSpaceBar(
                title: Text('My TO DO List'),
                centerTitle: true,
                expandedTitleScale: 1.5,
                collapseMode: CollapseMode.parallax,
                background: Image(
                  image: AssetImage('images/2.jpg'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  return ToDoTile(
                    taskName: db.todoList[index][0],
                    taskCompleted: db.todoList[index][1],
                    onChanged: (value) => checkBoxChange(value, index),
                    deleteTask: (context) => deleteTask(index),
                  );
                },
                childCount: db.todoList.length,
              ),
            )
          ],
        ),
      ),
    );
  }
}
