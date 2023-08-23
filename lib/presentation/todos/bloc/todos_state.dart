part of 'todos_bloc.dart';

class TodosState extends Equatable {
  final PageState pageState;
  final List<TodoModel> todos;
  final TodosFilter currentFilter;
  final Command? command;

  const TodosState({
    required this.pageState,
    required this.todos,
    required this.currentFilter,
    this.command,
  });

  @override
  List<Object?> get props => [
        pageState,
        todos,
        currentFilter,
        command,
      ];

  List<TodoModel> get filteredTodos => currentFilter.applyAll(todos);

  bool get hasAllTodosCompleted => todos.where((todo) => todo.isCompleted).length == todos.length;

  bool get enableDeleteAllCompleted => todos.where((todo) => todo.isCompleted).isNotEmpty;

  TodosState copyWith({
    PageState? pageState,
    List<TodoModel>? todos,
    TodosFilter? currentFilter,
    Command? command,
  }) {
    return TodosState(
      pageState: pageState ?? this.pageState,
      todos: todos ?? this.todos,
      currentFilter: currentFilter ?? this.currentFilter,
      command: command,
    );
  }

  factory TodosState.initial() {
    return const TodosState(pageState: PageState.initial, todos: [], currentFilter: TodosFilter.all);
  }
}
