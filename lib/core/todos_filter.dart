import 'package:todos_app/data/todo_model.dart';

enum TodosFilter {
  all,
  activeOnly,
  completedOnly;

  List<TodoModel> applyAll(List<TodoModel> todos) {
    return todos
        .where((i) => switch (this) {
              TodosFilter.all => true,
              TodosFilter.activeOnly => !i.isCompleted,
              TodosFilter.completedOnly => i.isCompleted,
            })
        .toList();
  }
}
