import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:to_do_list_app/helpers/database_helper.dart';
import 'package:to_do_list_app/models/task_model.dart';
import 'package:to_do_list_app/screens/add_task_screen.dart';

class ToDoListScreen extends StatefulWidget {
  @override
  _ToDoListScreenState createState() => _ToDoListScreenState();
}

class _ToDoListScreenState extends State<ToDoListScreen> {
  Future<List<Task>>? _taskList;
  final DateFormat _dateFormatter = DateFormat("MMM dd, yyyy");

  late Task task;
  @override
  void initState() {
    super.initState();
    _updateTaskList();
  }

  Widget _buildTask([param0]) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 25),
      child: Column(
        children: [
          ListTile(
            title: Text(
              task.title,
              style: TextStyle(
                  fontSize: 18,
                  decoration: task.status == 0
                      ? TextDecoration.none
                      : TextDecoration.lineThrough),
            ),
            subtitle: Text(
              '${_dateFormatter.format(task.date)} +  ${task.priority}',
              style: TextStyle(
                  fontSize: 15,
                  decoration: task.status == 0
                      ? TextDecoration.none
                      : TextDecoration.lineThrough),
            ),
            trailing: Checkbox(
              onChanged: (value) {
                if (value!) {
                  task.status = 1;
                } else {
                  task.status = 0;
                }
                DatabaseHelper.instance.updateTask(task);
                _updateTaskList();
              },
              value: task.status == 1 ? true : false,
              activeColor: Theme.of(context).primaryColor,
            ),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (_) => AddTaskScreen(
                        _updateTaskList,
                        task,
                      )),
            ),
          ),
          Divider(),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).primaryColor,
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => AddTaskScreen(
                _updateTaskList,
                task,
              ),
            ),
          );
        },
      ),
      body: FutureBuilder(
        future: _taskList,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          int completedTaskCount = snapshot.data.toString().length;
          return ListView.builder(
            padding: EdgeInsets.symmetric(vertical: 80.0),
            itemCount: snapshot.data.toString().length + 1,
            itemBuilder: (BuildContext context, int index) {
              if (index == 0) {
                return Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 40.0, vertical: 20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "my tasks",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 40.0,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 10.0),
                      Text(
                        "$completedTaskCount of ${snapshot.data!.toString().length}",
                        style: TextStyle(
                            color: Colors.grey,
                            fontSize: 20.0,
                            fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                );
              }
              return _buildTask(snapshot.data!.toString().length);
            },
          );
        },
      ),
    );
  }

  void _updateTaskList() {
    setState(() {
      _taskList = DatabaseHelper.instance.getTaskList();
    });
  }
}
