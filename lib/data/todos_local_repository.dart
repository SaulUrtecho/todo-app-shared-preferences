import 'dart:convert';

import 'package:rxdart/rxdart.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todos_app/data/todo_model.dart';

class TodosLocalRepository {
  static const todosKey = '__todos_key__';
  late final SharedPreferences _plugin;
  final _todoStreamController = BehaviorSubject<List<TodoModel>>.seeded(const []);

  TodosLocalRepository() {
    _init();
  }

  Future<void> _init() async {
    _plugin = await SharedPreferences.getInstance();
    final todosJson = _getValue(todosKey);
    if (todosJson != null) {
      final todos = List<Map<dynamic, dynamic>>.from(json.decode(todosJson) as List)
          .map((jsonMap) => TodoModel.fromJson(Map<String, dynamic>.from(jsonMap)))
          .toList();
      _todoStreamController.add(todos);
    } else {
      _todoStreamController.add(const []);
    }
  }

  String? _getValue(String key) => _plugin.getString(key);

  Future<void> _setValue(String key, String value) => _plugin.setString(key, value);

  Stream<List<TodoModel>> getTodos() => _todoStreamController.asBroadcastStream();

  Future<void> saveTodo(TodoModel todo) {
    final todos = [..._todoStreamController.value];
    final todoIndex = todos.indexWhere((t) => t.id == todo.id);
    //edit todo
    if (todoIndex >= 0) {
      todos[todoIndex] = todo;
    } else {
      todos.add(todo);
    }
    _todoStreamController.add(todos);
    return _setValue(todosKey, json.encode(todos));
  }

  Future<void> deleteTodo(String id) async {
    final todos = [..._todoStreamController.value];
    final todoIndex = todos.indexWhere((t) => t.id == id);
    if (todoIndex.isNegative) {
      throw 'Error deleting todo';
    } else {
      todos.removeAt(todoIndex);
      _todoStreamController.add(todos);
      return _setValue(todosKey, json.encode(todos));
    }
  }

  Future<int> deleteCompleted() async {
    final todos = [..._todoStreamController.value];
    final completedTodosAmount = todos.where((t) => t.isCompleted).length;
    todos.removeWhere((t) => t.isCompleted);
    _todoStreamController.add(todos);
    await _setValue(todosKey, json.encode(todos));
    return completedTodosAmount;
  }

  Future<int> markCompleteAll({required bool isCompleted}) async {
    final todos = [..._todoStreamController.value];
    final changedTodosAmount = todos.where((t) => t.isCompleted != isCompleted).length;
    final newTodos = [for (final todo in todos) todo.copyWith(isCompleted: isCompleted)];
    _todoStreamController.add(newTodos);
    await _setValue(todosKey, json.encode(newTodos));
    return changedTodosAmount;
  }
}
