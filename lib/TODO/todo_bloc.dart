import 'package:bloc/bloc.dart';
import 'todo_event.dart';
import 'todo_state.dart';

class TodoBloc extends Bloc<TodoEvent, TodoState> {
  TodoBloc() : super(TodoState([])) {
    on<AddTodo>((event, emit) {
      final updatedTodos = List<String>.from(state.todos)..add(event.task);
      emit(TodoState(updatedTodos));
    });

    on<RemoveTodo>((event, emit) {
      final updatedTodos = List<String>.from(state.todos)
        ..removeAt(event.index);
      emit(TodoState(updatedTodos));
    });

    on<EditTodo>((event, emit) {
      final updatedTodos = List<String>.from(state.todos)
        ..[event.index] = event.newTask;
      emit(TodoState(updatedTodos));
    });
  }
}
