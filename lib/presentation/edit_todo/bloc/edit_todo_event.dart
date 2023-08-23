part of 'edit_todo_bloc.dart';

class EditTodoEvent extends Equatable {
  const EditTodoEvent();

  @override
  List<Object> get props => [];
}

final class OnTitleChanged extends EditTodoEvent {
  final String title;

  const OnTitleChanged(this.title);

  @override
  String toString() => 'OnTitleChanged';
}

final class OnDescriptionChanged extends EditTodoEvent {
  final String description;
  const OnDescriptionChanged(this.description);

  @override
  String toString() => 'OnDescriptionChanged';
}

final class OnSubmitted extends EditTodoEvent {
  const OnSubmitted();

  @override
  String toString() => 'OnSubmitted';
}
