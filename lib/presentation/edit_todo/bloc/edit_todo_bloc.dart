import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:todos_app/core/page_state.dart';
import 'package:todos_app/data/todo_model.dart';
import 'package:todos_app/data/todos_local_repository.dart';

part 'edit_todo_event.dart';
part 'edit_todo_state.dart';

class EditTodoBloc extends Bloc<EditTodoEvent, EditTodoState> {
  final TodosLocalRepository todosLocalStorage;

  EditTodoBloc(TodoModel? initialTodo, this.todosLocalStorage) : super(EditTodoState.initial(initialTodo)) {
    on<OnTitleChanged>((event, emit) => emit(state.copyWith(title: event.title)));
    on<OnDescriptionChanged>((event, emit) => emit(state.copyWith(description: event.description)));
    on<OnSubmitted>(_onSubmitted);
  }

  Future<void> _onSubmitted(OnSubmitted event, Emitter<EditTodoState> emit) async {
    emit(state.copyWith(status: PageState.loading));
    final todo =
        (state.initialTodo ?? TodoModel(title: '')).copyWith(title: state.title, description: state.description);
    try {
      await todosLocalStorage.saveTodo(todo);
      emit(state.copyWith(status: PageState.success));
    } catch (e) {
      emit(state.copyWith(status: PageState.failure));
    }
  }
}
