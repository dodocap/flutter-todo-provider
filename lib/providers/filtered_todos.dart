import 'package:equatable/equatable.dart';
import 'package:todo_provider/model/todo_model.dart';
import 'package:todo_provider/providers/todo_filter.dart';
import 'package:todo_provider/providers/todo_list.dart';
import 'package:todo_provider/providers/todo_search.dart';

class FilteredTodosState extends Equatable {
  final List<Todo> filteredTodos;

  FilteredTodosState({
    required this.filteredTodos,
  });

  factory FilteredTodosState.initial() {
    return FilteredTodosState(filteredTodos: []);
  }

  @override
  List<Object?> get props => [ filteredTodos ];

  @override
  bool? get stringify => true;

  FilteredTodosState copyWith({
    List<Todo>? filteredTodos,
  }) {
    return FilteredTodosState(
      filteredTodos: filteredTodos ?? this.filteredTodos,
    );
  }
}

class FilteredTodos {
  final TodoFilter todoFilter;
  final TodoSearch todoSearch;
  final TodoList todoList;

  FilteredTodos({
    required this.todoFilter,
    required this.todoSearch,
    required this.todoList,
  });

  FilteredTodosState get state {
    List<Todo> _filteredTodos;

    switch (todoFilter.state.filter) {
      case Filter.active:
        _filteredTodos = todoList.state.todos.where((todo) => !todo.completed).toList();
      case Filter.completed:
        _filteredTodos = todoList.state.todos.where((todo) => todo.completed).toList();
      case Filter.all:
        _filteredTodos = todoList.state.todos;
    }

    if (todoSearch.state.searchTerm.isNotEmpty) {
      _filteredTodos = _filteredTodos
          .where((todo) => todo.desc.toLowerCase().contains(todoSearch.state.searchTerm.toLowerCase()))
          .toList();
    }

    return FilteredTodosState(filteredTodos: _filteredTodos);
  }
}