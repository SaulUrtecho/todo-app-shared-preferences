import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todos_app/data/todos_local_repository.dart';
import 'package:todos_app/presentation/todos_app.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    return RepositoryProvider(
      create: (_) => TodosLocalRepository(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'todos app',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
          useMaterial3: true,
        ),
        home: const TodosApp(),
      ),
    );
  }
}
