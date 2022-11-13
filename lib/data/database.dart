import 'package:hive_flutter/hive_flutter.dart';

class TodoDatabase{

  List toDoList = [];
  final _box = Hive.box('box');

  void createInitialData(){
    toDoList = [
      ['Build app', false],
      ['Workout', false],
    ];
  }

  void loadData(){
    toDoList = _box.get('TODOLIST');
  }

  void updateDataBase(){
    _box.put('TODOLIST', toDoList);
  }

}