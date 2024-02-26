import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_provider/pages/todos_page.dart';
import 'package:todo_provider/providers/providers.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<TodoFilter>(
          create: (_) => TodoFilter(),
        ),
        ChangeNotifierProvider<TodoSearch>(
          create: (_) => TodoSearch(),
        ),
        ChangeNotifierProvider<TodoList>(
          create: (_) => TodoList(),
        ),
        ChangeNotifierProxyProvider<TodoList, ActiveTodoCount>(
          create: (context) => ActiveTodoCount(initialActiveTodoCount: context.read<TodoList>().state.todos.length),
          update: (_, todoList, activeTodoCount) {
            return activeTodoCount!..update(todoList);
          },
        ),
        ChangeNotifierProxyProvider3<TodoFilter, TodoSearch, TodoList, FilteredTodos>(
          create: (context) => FilteredTodos(initialFilteredTodos: context.read<TodoList>().state.todos),
          update: (_, todoFilter, todoSearch, todoList, filteredTodos) {
            return filteredTodos!..update(todoFilter, todoSearch, todoList);
          },
        ),
      ],
      child: MaterialApp(
        title: 'TODOS',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const TodosPage(),
      ),
    );
  }
}