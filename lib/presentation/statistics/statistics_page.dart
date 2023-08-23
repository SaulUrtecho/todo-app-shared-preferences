import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todos_app/data/todos_local_repository.dart';
import 'package:todos_app/presentation/statistics/bloc/statistics_bloc.dart';

class StatisticsPage extends StatelessWidget {
  const StatisticsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => StatisticsBloc(context.read<TodosLocalRepository>())..add(const Initial()),
      child: const StatisticsView(),
    );
  }
}

class StatisticsView extends StatelessWidget {
  const StatisticsView({super.key});

  @override
  Widget build(BuildContext context) {
    final state = context.watch<StatisticsBloc>().state;
    return Scaffold(
      appBar: AppBar(title: const Text('Statistics')),
      body: ColoredBox(
        color: Colors.grey,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              StatisticsRow(currentTodosStatus: state.completedTodos, title: 'Completed Todos'),
              const SizedBox(height: 24),
              StatisticsRow(currentTodosStatus: state.activeTodos, title: 'Active Todos'),
            ],
          ),
        ),
      ),
    );
  }
}

class StatisticsRow extends StatelessWidget {
  final int currentTodosStatus;
  final String title;

  const StatisticsRow({super.key, required this.currentTodosStatus, required this.title});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Icon(Icons.radio_button_unchecked_rounded),
        const SizedBox(width: 24),
        Expanded(child: Text(title, style: Theme.of(context).textTheme.labelLarge)),
        Text('$currentTodosStatus', style: const TextStyle(fontSize: 18)),
      ],
    );
  }
}
