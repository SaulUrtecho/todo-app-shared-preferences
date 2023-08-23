import 'package:todos_app/data/todo_model.dart';

abstract class Command {}

class ShowSnackError extends Command {
  final String error;

  ShowSnackError(this.error);
}

class ShowSnackTodoDeleted extends Command {
  final TodoModel todo;

  ShowSnackTodoDeleted(this.todo);
}
