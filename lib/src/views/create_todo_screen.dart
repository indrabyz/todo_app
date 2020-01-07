import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:todo_app/src/database/todo_db_helper.dart';
import 'package:todo_app/src/models/todo.dart';

class CreateTodoScreen extends StatefulWidget {
  final Todo todo;
  CreateTodoScreen({Key key, this.todo}) : super(key: key);

  @override
  _CreateTodoScreenState createState() => _CreateTodoScreenState();
}

class _CreateTodoScreenState extends State<CreateTodoScreen> {
  final TextEditingController taskController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  @override
  void initState() {
    if (widget.todo != null) {
      taskController.text = widget.todo.task;
      descriptionController.text = widget.todo.description;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightGreen,
        title: Text('Todo'),
        iconTheme: IconThemeData(color: Colors.blueAccent),
        actions: <Widget>[
          InkWell(
            onTap: () {
              deleteTodo();
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Icon(MdiIcons.checkBold),
            ),
          )
        ],
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
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  Future saveTodo() async {
    var db = TodoDBHelper();
    var todo = Todo(
      task: taskController.text,
      description: descriptionController.text,
    );

    var result;
    if (widget.todo != null) {
      todo.id = widget.todo.id;
      result = await db.updateTodo(todo, widget.todo.id);
    } else {
      result = await db.addTodo(todo);
    }

    if (result != 0) {
      Navigator.pop(context);
    }
  }

  Future deleteTodo() async {
    var db = TodoDBHelper();
    var result = 
      await db.deleteTodo(widget.todo.id);
    
    if (result != 0) {
      Navigator.pop(context);
    }
  }
}
