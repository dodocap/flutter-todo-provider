import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:todo_provider/providers/todo_list.dart';

class ActiveTodoCountState extends Equatable {
  final int activeTodoCount;

  ActiveTodoCountState({
    required this.activeTodoCount,
  });

  factory ActiveTodoCountState.initial() {
    return ActiveTodoCountState(activeTodoCount: 0);
  }

  @override
  List<Object?> get props => [ activeTodoCount ];

  @override
  bool? get stringify => true;

  ActiveTodoCountState copyWith({
    int? activeTodoCount,
  }) {
    return ActiveTodoCountState(
      activeTodoCount: activeTodoCount ?? this.activeTodoCount,
    );
  }
}

class ActiveTodoCount with ChangeNotifier {
  // ActiveTodoCountState _state = ActiveTodoCountState.initial();
  final int initialActiveTodoCount;

  late ActiveTodoCountState _state;

  ActiveTodoCountState get state => _state;

  ActiveTodoCount({
    required this.initialActiveTodoCount,
  }) {
    _state = ActiveTodoCountState(activeTodoCount: initialActiveTodoCount);
  }

  void update(TodoList todoList) {
    final int newActiveTodoCount = todoList.state.todos.where((todo) => !todo.completed).length;

    _state = _state.copyWith(activeTodoCount: newActiveTodoCount);
    notifyListeners();
  }
}