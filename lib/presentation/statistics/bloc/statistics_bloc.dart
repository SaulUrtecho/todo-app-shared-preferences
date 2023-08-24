import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:todos_app/core/page_state.dart';
import 'package:todos_app/data/todo_model.dart';
import 'package:todos_app/data/todos_local_repository.dart';

part 'statistics_event.dart';
part 'statistics_state.dart';

class StatisticsBloc extends Bloc<StatisticsEvent, StatisticsState> {
  final TodosLocalRepository todosLocalRepository;

  StatisticsBloc(this.todosLocalRepository) : super(StatisticsState.initial()) {
    on<Initial>(_initial);
  }

  Future<void> _initial(Initial event, Emitter emit) async {
    emit(state.copyWith(status: PageState.loading));
    await emit.forEach<List<TodoModel>>(
      todosLocalRepository.getTodos(),
      onData: (todos) => state.copyWith(
        status: PageState.success,
        completedTodos: todos.where((todo) => todo.isCompleted).length,
        activeTodos: todos.where((todo) => !todo.isCompleted).length,
      ),
      onError: (_, __) => state.copyWith(status: PageState.failure),
    );
  }
}
