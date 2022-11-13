import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:tudu/colors.dart';
import 'package:tudu/data/database.dart';
import 'package:tudu/widgets/dialog_box.dart';
import 'package:tudu/widgets/todo_tile.dart';

void main() async {
  await Hive.initFlutter();
  var box = await Hive.openBox('box');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Flutter Demo',
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _box = Hive.box('box');
  TodoDatabase db = TodoDatabase();
  final TextEditingController _controller = TextEditingController();

  void checkBoxChanged(bool? value, int index) {
    setState(() {
      db.toDoList[index][1] = !db.toDoList[index][1];
    });
    db.updateDataBase();
  }

  //TODO: toast - cannot be empty
  void createNewTask() {
    showDialog(
        context: context,
        builder: (context) {
          return DialogBox(
            controller: _controller,
            onSave: () {
              if (_controller.text.isEmpty) {
                Navigator.of(context).pop();
                ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Task can\'t be empty!')));
              } else {
                setState(() {
                  db.toDoList.add([_controller.text, false]);
                  _controller.clear();
                });
                Navigator.of(context).pop();
                db.updateDataBase();
              }
            },
          );
        });
  }

  void deleteTask(int index) {
    setState(() {
      db.toDoList.removeAt(index);
    });
    db.updateDataBase();
  }

  @override
  void initState() {
    if (_box.get('TODOLIST') == null) {
      db.createInitialData();
    } else {
      db.loadData();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: lightestBlue,
      appBar: AppBar(
        title: const Center(child: Text("TO DO")),
        backgroundColor: darkBlue,
        elevation: 0,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: createNewTask,
        backgroundColor: purple,
        child: const Icon(Icons.add),
      ),
      body: ListView.builder(
        itemCount: db.toDoList.length,
        itemBuilder: (context, index) {
          return ToDoTile(
            taskName: db.toDoList[index][0],
            taskCompleted: db.toDoList[index][1],
            onChanged: (value) => checkBoxChanged(value, index),
            delete: (context) => deleteTask(index),
          );
        },
      ),
    );
  }
}
