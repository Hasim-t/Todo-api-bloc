import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:todo_api_bloc/model/add_todo.dart';
import 'package:todo_api_bloc/screen/addpage.dart';

part 'todo_event.dart';
part 'todo_state.dart';

class TodoBloc extends Bloc<TodoEvent, TodoState> {
  TodoBloc() : super(TodoInitial()) {
    on<addEventTodo>(addeventTode);
  }

  FutureOr<void> addeventTode(
      addEventTodo event, Emitter<TodoState> emit) async {
    emit(AddstateTodo());
   
  }
}
