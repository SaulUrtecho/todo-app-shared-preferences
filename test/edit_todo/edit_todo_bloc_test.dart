import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:todos_app/data/todo_model.dart';
import 'package:todos_app/data/todos_local_repository.dart';
import 'package:todos_app/presentation/edit_todo/bloc/edit_todo_bloc.dart';

class MockTodosRepository extends Mock implements TodosLocalRepository {}

class FakeTodo extends Fake implements TodoModel {}

void main() {
  group('EditTodoBloc', () {
    late TodosLocalRepository todosLocalRepository;

    setUpAll(() => registerFallbackValue(FakeTodo()));
    setUp(() => todosLocalRepository = MockTodosRepository());

    EditTodoBloc buildBloc() {
      return EditTodoBloc(null, todosLocalRepository);
    }

    group('constructor', () {
      test('works properly', () {
        expect(buildBloc, returnsNormally);
      });

      test('has correct initial state', () {
        expect(
          buildBloc().state,
          equals(EditTodoState.initial(null)),
        );
      });
    });
  });
}
