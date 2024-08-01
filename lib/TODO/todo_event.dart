abstract class TodoEvent {}

class AddTodo extends TodoEvent {
  final String task;

  AddTodo(this.task);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AddTodo &&
          runtimeType == other.runtimeType &&
          task == other.task;

  @override
  int get hashCode => task.hashCode;
}

class RemoveTodo extends TodoEvent {
  final int index;

  RemoveTodo(this.index);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is RemoveTodo &&
          runtimeType == other.runtimeType &&
          index == other.index;

  @override
  int get hashCode => index.hashCode;
}

class EditTodo extends TodoEvent {
  final int index;
  final String newTask;

  EditTodo(this.index, this.newTask);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is EditTodo &&
          runtimeType == other.runtimeType &&
          index == other.index &&
          newTask == other.newTask;

  @override
  int get hashCode => index.hashCode ^ newTask.hashCode;
}
