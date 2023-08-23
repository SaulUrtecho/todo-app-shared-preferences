import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todos_app/presentation/todos/bloc/todos_bloc.dart';

class TodosOptionsMenu extends StatelessWidget {
  const TodosOptionsMenu({super.key});

  @override
  Widget build(BuildContext context) {
    final state = context.watch<TodosBloc>().state;
    return PopupMenuButton(
      itemBuilder: (context) {
        return [
          PopupMenuItem(
            onTap: () => context.read<TodosBloc>().add(const OnTodosToggleAll()),
            enabled: state.todos.isNotEmpty,
            child: Text('Mark all as ${state.hasAllTodosCompleted ? 'incomplete' : 'complete'}'),
          ),
          PopupMenuItem(
            onTap: () => context.read<TodosBloc>().add(const OnTodosDeleteAll()),
            enabled: state.enableDeleteAllCompleted,
            child: const Text('Delete completed'),
          ),
        ];
      },
    );
  }
}
