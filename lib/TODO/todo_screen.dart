import 'package:bloc_api/TODO/todo_bloc.dart';
import 'package:bloc_api/TODO/todo_event.dart';
import 'package:bloc_api/TODO/todo_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyApp1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: BlocProvider(
        create: (context) => TodoBloc(),
        child: TodoPage(),
      ),
    );
  }
}

class TodoPage extends StatelessWidget {
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final todoBloc = BlocProvider.of<TodoBloc>(context);

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: NetworkImage(
                "https://images7.alphacoders.com/131/1318803.jpeg"),
            fit: BoxFit.fill,
          ),
        ),
        child: Column(
          children: <Widget>[
            Container(
              margin: const EdgeInsets.only(top: 80, bottom: 30),
              child: const Text(
                'BLoC Todo Demo',
                style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: TextField(
                style: const TextStyle(color: Colors.white),
                controller: _controller,
                decoration: InputDecoration(
                  labelText: 'Enter task',
                  fillColor: Colors.white,
                  labelStyle: const TextStyle(color: Colors.white),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20)),
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                todoBloc.add(AddTodo(_controller.text));
                _controller.clear();
              },
              child: const Text('Add Task'),
            ),
            Expanded(
              child: BlocBuilder<TodoBloc, TodoState>(
                builder: (context, state) {
                  return ListView.builder(
                    padding: EdgeInsets.zero,
                    itemCount: state.todos.length,
                    itemBuilder: (context, index) {
                      return Container(
                        margin: const EdgeInsets.all(10),
                        child: Material(
                          borderRadius: BorderRadius.circular(15),
                          color: Colors.white,
                          elevation: 15,
                          child: ListTile(
                            title: Text(state.todos[index]),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                IconButton(
                                  icon: const Icon(Icons.edit),
                                  onPressed: () {
                                    _showEditDialog(
                                        context, index, state.todos[index]);
                                  },
                                ),
                                IconButton(
                                  icon: const Icon(Icons.delete),
                                  onPressed: () {
                                    todoBloc.add(RemoveTodo(index));
                                    _showSnackBar(context, 'Task deleted');
                                  },
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showEditDialog(BuildContext context, int index, String currentTask) {
    final TextEditingController editController =
        TextEditingController(text: currentTask);
    final todoBloc = BlocProvider.of<TodoBloc>(context);

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Edit Task'),
          content: TextField(
            controller: editController,
            decoration: const InputDecoration(
              labelText: 'New task',
              border: OutlineInputBorder(),
            ),
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                todoBloc.add(EditTodo(index, editController.text));
                Navigator.of(context).pop();
              },
              child: const Text('Save'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
          ],
        );
      },
    );
  }

  void _showSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));
  }
}
