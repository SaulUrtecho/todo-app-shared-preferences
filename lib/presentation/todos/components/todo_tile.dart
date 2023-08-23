import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todos_app/data/todo_model.dart';
import 'package:todos_app/presentation/edit_todo/edit_todo_page.dart';
import 'package:todos_app/presentation/todos/bloc/todos_bloc.dart';

class TodoTile extends StatelessWidget {
  final TodoModel todo;

  const TodoTile({super.key, required this.todo});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        child: Row(
          children: [
            const SizedBox(width: 8),
            Checkbox(
              shape: const ContinuousRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(8))),
              value: todo.isCompleted,
              onChanged: (isCompleted) => context.read<TodosBloc>().add(OnTodoCompletedToggle(todo, isCompleted!)),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: GestureDetector(
                onTap: () => Navigator.of(context).push(EditTodoPage.route(initialTodo: todo)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(todo.title, style: Theme.of(context).textTheme.labelLarge),
                    Text(
                      todo.description,
                      maxLines: 1,
                      style: Theme.of(context).textTheme.labelMedium!.copyWith(color: Colors.black45),
                    ),
                  ],
                ),
              ),
            ),
            IconButton(
              onPressed: () => context.read<TodosBloc>().add(OnTodoDeleted(todo)),
              icon: const Icon(Icons.delete),
            )
          ],
        ),
      ),
    );
  }
}
