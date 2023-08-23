import 'package:flutter/material.dart';
import 'package:todos_app/presentation/edit_todo/edit_todo_page.dart';
import 'package:todos_app/presentation/statistics/statistics_page.dart';
import 'package:todos_app/presentation/todos/todos_page.dart';

class TodosApp extends StatefulWidget {
  const TodosApp({super.key});

  @override
  State<TodosApp> createState() => _TodosAppState();
}

class _TodosAppState extends State<TodosApp> {
  HomeTab currentTab = HomeTab.todos;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: currentTab.index,
        children: const [
          TodosPage(),
          StatisticsPage(),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.of(context).push(EditTodoPage.route()),
        key: const Key('homeView_addTodo_floatingActionButton'),
        child: const Icon(Icons.add),
      ),
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            IconButton(
                onPressed: () => setState(() => currentTab = HomeTab.todos),
                icon: const Icon(Icons.list_rounded),
                color: currentTab == HomeTab.todos ? Colors.red : null),
            IconButton(
                onPressed: () => setState(() => currentTab = HomeTab.stats),
                icon: const Icon(Icons.show_chart_rounded),
                color: currentTab == HomeTab.stats ? Colors.red : null)
          ],
        ),
      ),
    );
  }
}

enum HomeTab { todos, stats }
