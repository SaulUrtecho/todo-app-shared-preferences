part of 'statistics_bloc.dart';

class StatisticsEvent extends Equatable {
  const StatisticsEvent();

  @override
  List<Object> get props => [];
}

final class Initial extends StatisticsEvent {
  const Initial();

  @override
  String toString() => 'Initial';
}
