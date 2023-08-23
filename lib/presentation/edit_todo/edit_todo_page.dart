import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todos_app/core/page_state.dart';
import 'package:todos_app/data/todo_model.dart';
import 'package:todos_app/data/todos_local_repository.dart';
import 'package:todos_app/presentation/edit_todo/bloc/edit_todo_bloc.dart';

class EditTodoPage extends StatelessWidget {
  final TodoModel? initialTodo;

  const EditTodoPage({super.key, this.initialTodo});

  static Route route({TodoModel? initialTodo}) {
    return MaterialPageRoute(
      builder: (_) => EditTodoPage(initialTodo: initialTodo),
      fullscreenDialog: true,
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => EditTodoBloc(initialTodo, context.read<TodosLocalRepository>()),
      child: BlocConsumer<EditTodoBloc, EditTodoState>(
        listenWhen: (previous, current) => current.status == PageState.success,
        listener: (context, state) => Navigator.of(context).pop(),
        builder: (context, state) {
          final isLoading = state.status == PageState.loading;
          return Scaffold(
            appBar: AppBar(title: const Text('Add Todo')),
            body: isLoading
                ? const CircularProgressIndicator()
                : Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      children: [
                        TextFormField(
                          initialValue: state.title,
                          decoration: const InputDecoration(labelText: 'Title'),
                          maxLength: 50,
                          maxLines: null,
                          onChanged: (value) => context.read<EditTodoBloc>().add(OnTitleChanged(value)),
                        ),
                        const SizedBox(height: 24),
                        TextFormField(
                          initialValue: state.description,
                          decoration: const InputDecoration(labelText: 'Description'),
                          maxLength: 300,
                          maxLines: null,
                          onChanged: (value) => context.read<EditTodoBloc>().add(OnDescriptionChanged(value)),
                        ),
                      ],
                    ),
                  ),
            floatingActionButton: FloatingActionButton(
              onPressed: isLoading ? null : () => context.read<EditTodoBloc>().add(const OnSubmitted()),
              child: isLoading ? const CupertinoActivityIndicator() : const Icon(Icons.check_rounded),
            ),
          );
        },
      ),
    );
  }
}
