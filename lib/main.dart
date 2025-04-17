import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'features/todo/presentation/pages/todo_page.dart';
import 'features/todo/presentation/controllers/todo_controller.dart';
import 'features/todo/data/repositories_impl/todo_repository_mock.dart';

void main() {
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => TodoController(TodoRepositoryMock())..loadTodos(),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ToDo App',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const TodoPage(),
    );
  }
}
