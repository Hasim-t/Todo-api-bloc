part of 'todo_bloc.dart';

@immutable
sealed class TodoEvent {}

class addEventTodo extends TodoEvent{}