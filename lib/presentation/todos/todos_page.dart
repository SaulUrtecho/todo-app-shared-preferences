import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todos_app/data/todos_local_repository.dart';
import 'package:todos_app/presentation/todos/bloc/commands.dart';
import 'package:todos_app/presentation/todos/bloc/todos_bloc.dart';
import 'package:todos_app/presentation/todos/components/todo_tile.dart';
import 'package:todos_app/presentation/todos/components/todos_filters_menu.dart';
import 'package:todos_app/presentation/todos/components/todos_options_menu.dart';

class TodosPage extends StatelessWidget {
  const TodosPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TodosBloc(context.read<TodosLocalRepository>())..add(const Initial()),
      child: BlocListener<TodosBloc, TodosState>(
        listenWhen: (_, current) => current.command != null,
        listener: (context, state) {
          final command = state.command;
          final messenger = ScaffoldMessenger.of(context);
          if (command is ShowSnackTodoDeleted) {
            messenger
              ..hideCurrentSnackBar()
              ..showSnackBar(SnackBar(
                content: Text('Todo ${command.todo.title} deleted'),
                behavior: SnackBarBehavior.floating,
                action: SnackBarAction(
                  label: 'Undo',
                  onPressed: () {
                    messenger.hideCurrentSnackBar();
                    context.read<TodosBloc>().add(OnRestoreDeleted(command.todo));
                  },
                ),
              ));
          }
          if (command is ShowSnackError) {
            messenger
              ..hideCurrentSnackBar()
              ..showSnackBar(SnackBar(
                content: Text(command.error),
                behavior: SnackBarBehavior.floating,
              ));
          }
          context.read<TodosBloc>().add(const ClearCommand());
        },
        child: Scaffold(
          appBar: AppBar(title: const Text('Todos'), actions: const [TodosFiltersMenu(), TodosOptionsMenu()]),
          body: BlocBuilder<TodosBloc, TodosState>(
            builder: (context, state) {
              return ColoredBox(
                color: Colors.grey,
                child: ListView.separated(
                  padding: const EdgeInsets.all(16),
                  itemCount: state.filteredTodos.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 8),
                  itemBuilder: (_, index) => TodoTile(todo: state.filteredTodos[index]),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
