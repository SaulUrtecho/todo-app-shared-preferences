import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:todos_app/core/page_state.dart';
import 'package:todos_app/core/todos_filter.dart';
import 'package:todos_app/data/todo_model.dart';
import 'package:todos_app/data/todos_local_repository.dart';
import 'package:todos_app/presentation/todos/bloc/commands.dart';

part 'todos_event.dart';
part 'todos_state.dart';

class TodosBloc extends Bloc<TodosEvent, TodosState> {
  final TodosLocalRepository todosLocalRepository;
  TodosBloc(this.todosLocalRepository) : super(TodosState.initial()) {
    on<Initial>(_initial);
    on<OnTodoDeleted>(_onTodoDeleted);
    on<OnTodoCompletedToggle>(_onTodoCompletedToggle);
    on<OnTodosToggleAll>(_onTodosToggleAll);
    on<OnTodosDeleteAll>(_onTodosDeleteAll);
    on<OnFilterSelected>((event, emit) => emit(state.copyWith(currentFilter: event.filter)));
    on<ClearCommand>((_, emit) => emit(state.copyWith()));
    on<OnRestoreDeleted>(_onRestoreDeleted);
  }

  Future<void> _initial(Initial event, Emitter<TodosState> emit) async {
    emit(state.copyWith(pageState: PageState.loading));
    await emit.forEach<List<TodoModel>>(
      todosLocalRepository.getTodos(),
      onData: (todos) => state.copyWith(pageState: PageState.success, todos: todos),
      onError: (error, __) => state.copyWith(pageState: PageState.failure, command: ShowSnackError('$error')),
    );
  }

  Future<void> _onTodoDeleted(OnTodoDeleted event, Emitter emit) async {
    await todosLocalRepository.deleteTodo(event.todo.id);
    emit(state.copyWith(command: ShowSnackTodoDeleted(event.todo)));
  }

  Future<void> _onTodoCompletedToggle(OnTodoCompletedToggle event, Emitter emit) async {
    final newTodo = event.todo.copyWith(isCompleted: event.isCompleted);
    await todosLocalRepository.saveTodo(newTodo);
  }

  Future<void> _onTodosToggleAll(OnTodosToggleAll event, Emitter emit) async {
    final allCompleted = state.todos.every((todo) => todo.isCompleted);
    await todosLocalRepository.markCompleteAll(isCompleted: !allCompleted);
  }

  Future<void> _onTodosDeleteAll(OnTodosDeleteAll event, Emitter emit) async {
    await todosLocalRepository.deleteCompleted();
  }

  Future<void> _onRestoreDeleted(OnRestoreDeleted event, Emitter emit) async {
    await todosLocalRepository.saveTodo(event.todo);
  }
}
