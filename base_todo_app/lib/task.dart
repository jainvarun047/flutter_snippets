import 'package:json_annotation/json_annotation.dart';

part 'task.g.dart';

enum TaskStatus { InProgress, Completed }

@JsonSerializable()
class Task {
  String id = 'Task-${DateTime.now().microsecondsSinceEpoch}';
  String title;
  List<String> tags;
  DateTime createDate = DateTime.now();
  TaskStatus status = TaskStatus.InProgress;
  DateTime lastStatusDate = DateTime.now();
  String details;

  Task(this.title, this.details, this.tags);

  factory Task.fromJson(Map<String, dynamic> json) => _$TaskFromJson(json);
  Map<String, dynamic> toJson() => _$TaskToJson(this);

  bool get isCompleted {
    if (status == TaskStatus.Completed) {
      return true;
    }
    return false;
  }

  void toggleStatus() {
    if (status == TaskStatus.Completed) {
      status = TaskStatus.InProgress;
      return;
    }
    status = TaskStatus.Completed;
  }
}
