import 'package:hive_flutter/hive_flutter.dart';

class ToDoDataBase {
  List todoList = [];

  // reference the hive box
  final myTodoBox = Hive.box('todoBox');

  // run the app for the first time*
  void createInitialData() {
    todoList = [
      ['Make tuto', false],
      ['Go exercise', false],
    ];
  }

  // load Data
  void loadData() {
    todoList = myTodoBox.get('TODOLIST');
  }

  // update the data
  void updateData() {
    myTodoBox.put('TODOLIST', todoList);
  }
}
