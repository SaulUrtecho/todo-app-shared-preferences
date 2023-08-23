part of 'statistics_bloc.dart';

class StatisticsState extends Equatable {
  final PageState status;
  final int completedTodos;
  final int activeTodos;

  const StatisticsState({required this.status, required this.completedTodos, required this.activeTodos});

  @override
  List<Object> get props => [status, completedTodos, activeTodos];

  StatisticsState copyWith({
    PageState? status,
    int? completedTodos,
    int? activeTodos,
  }) {
    return StatisticsState(
      status: status ?? this.status,
      completedTodos: completedTodos ?? this.completedTodos,
      activeTodos: activeTodos ?? this.activeTodos,
    );
  }

  factory StatisticsState.initial() {
    return const StatisticsState(status: PageState.initial, completedTodos: 0, activeTodos: 0);
  }
}
