part of 'todos_bloc.dart';

class TodosEvent extends Equatable {
  const TodosEvent();

  @override
  List<Object> get props => [];
}

final class Initial extends TodosEvent {
  const Initial();

  @override
  String toString() => 'Initial';
}

final class OnTodoDeleted extends TodosEvent {
  final TodoModel todo;
  const OnTodoDeleted(this.todo);

  @override
  String toString() => 'OnTodoDeleted';
}

final class OnTodoCompletedToggle extends TodosEvent {
  final TodoModel todo;
  final bool isCompleted;
  const OnTodoCompletedToggle(this.todo, this.isCompleted);

  @override
  String toString() => 'OnTodoCompletedToggle';
}

final class OnTodosToggleAll extends TodosEvent {
  const OnTodosToggleAll();

  @override
  String toString() => 'OnTodosToggleAll';
}

final class OnTodosDeleteAll extends TodosEvent {
  const OnTodosDeleteAll();

  @override
  String toString() => 'OnTodosDeleteAll';
}

final class OnFilterSelected extends TodosEvent {
  final TodosFilter filter;
  const OnFilterSelected(this.filter);

  @override
  String toString() => 'OnFilterSelected';
}

final class ClearCommand extends TodosEvent {
  const ClearCommand();

  @override
  String toString() => 'ClearCommand';
}

final class OnRestoreDeleted extends TodosEvent {
  final TodoModel todo;

  const OnRestoreDeleted(this.todo);
  @override
  String toString() => 'OnRestoreDeleted';
}
