

class TodoState {
  final List<String> todos;

  TodoState(this.todos);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TodoState &&
          runtimeType == other.runtimeType &&
          todos == other.todos;

  @override
  int get hashCode => todos.hashCode;
}
