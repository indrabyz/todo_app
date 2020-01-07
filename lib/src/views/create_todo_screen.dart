import 'package:flutter/material.dart';
import 'package:todo_app/src/database/todo_db_helper.dart';
import 'package:todo_app/src/models/todo.dart';

class CreateTodoScreen extends StatefulWidget {
  @override
  _CreateTodoScreenState createState() => _CreateTodoScreenState();
}

class _CreateTodoScreenState extends State<CreateTodoScreen> {
  final TextEditingController taskController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightGreen,
        title: Text('Add Todo'),
        iconTheme: IconThemeData(color: Colors.blueAccent),
      ),
      body: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 20, 16, 20),
            child: TextFormField(
              controller: taskController,
              decoration: InputDecoration(labelText: 'Task Name'),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 20, 16, 20),
            child: TextFormField(
              controller: descriptionController,
              maxLines: 3,
              decoration: InputDecoration(labelText: 'Description'),
            ),
          ),
        ],
      ),
      floatingActionButton: Container(
        width: double.infinity,
        margin: EdgeInsets.fromLTRB(20, 10, 20, 10),
        child: RaisedButton(
          color: Colors.blue,
          onPressed: () {
            saveTodo();
          },
          child: Text(
            'Save',
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
      floatingActionButtonLocation: 
        FloatingActionButtonLocation.centerFloat,
    );
  }

  Future saveTodo() async {
    var db = TodoDBHelper();
    var todo = Todo(
      task: taskController.text,
      description: descriptionController.text,
    );

    var result;
    result = await db.addTodo(todo);

    if (result != 0) {
      Navigator.pop(context);
    }
  }
}
