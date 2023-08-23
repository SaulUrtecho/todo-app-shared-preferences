part of 'edit_todo_bloc.dart';

class EditTodoState extends Equatable {
  final PageState status;
  final TodoModel? initialTodo;
  final String title;
  final String description;

  const EditTodoState({
    required this.status,
    this.initialTodo,
    required this.title,
    required this.description,
  });

  @override
  List<Object?> get props => [status, initialTodo, title, description];

  bool get isNewTodo => initialTodo == null;

  EditTodoState copyWith({
    PageState? status,
    TodoModel? initialTodo,
    String? title,
    String? description,
  }) {
    return EditTodoState(
      status: status ?? this.status,
      title: title ?? this.title,
      description: description ?? this.description,
      initialTodo: initialTodo ?? this.initialTodo,
    );
  }

  factory EditTodoState.initial(TodoModel? initialTodo) {
    return EditTodoState(
      status: PageState.initial,
      title: initialTodo?.title ?? '',
      description: initialTodo?.description ?? '',
      initialTodo: initialTodo,
    );
  }
}
