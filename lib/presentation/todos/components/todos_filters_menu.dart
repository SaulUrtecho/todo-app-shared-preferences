import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todos_app/core/todos_filter.dart';
import 'package:todos_app/presentation/todos/bloc/todos_bloc.dart';

class TodosFiltersMenu extends StatelessWidget {
  const TodosFiltersMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
        initialValue: context.select((TodosBloc bloc) => bloc.state.currentFilter),
        onSelected: (filterSelected) => context.read<TodosBloc>().add(OnFilterSelected(filterSelected)),
        tooltip: 'Filter',
        icon: const Icon(Icons.filter_list_rounded),
        itemBuilder: (context) {
          return [
            const PopupMenuItem(value: TodosFilter.all, child: Text('All')),
            const PopupMenuItem(value: TodosFilter.activeOnly, child: Text('Active')),
            const PopupMenuItem(value: TodosFilter.completedOnly, child: Text('Completed')),
          ];
        });
  }
}
