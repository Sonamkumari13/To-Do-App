import 'package:equatable/equatable.dart';
import '../utils/task_category.dart';
import 'package:to_do_list/utils/utils.dart';

class Task extends Equatable{
  final int? id;
  final String title;
  final String note;
  final String time;
  final String date;
  final TaskCategories category;
  final bool isCompleted;

//<editor-fold desc="Data Methods">
  const Task({
    this.id,
    required this.title,
    required this.note,
    required this.time,
    required this.date,
    required this.category,
    required this.isCompleted,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Task &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          title == other.title &&
          note == other.note &&
          time == other.time &&
          date == other.date &&
          isCompleted == other.isCompleted);

  @override
  int get hashCode =>
      id.hashCode ^
      title.hashCode ^
      note.hashCode ^
      time.hashCode ^
      date.hashCode ^
      isCompleted.hashCode;

  @override
  String toString() {
    return 'Task{' +
        ' id: $id,' +
        ' title: $title,' +
        ' note: $note,' +
        ' time: $time,' +
        ' date: $date,' +
        ' isComplete: $isCompleted,' +
        '}';
  }

  Task copyWith({
    int? id,
    String? title,
    String? note,
    String? time,
    String? date,
    bool? isComplete,
  }) {
    return Task(
      id: id ?? this.id,
      title: title ?? this.title,
      note: note ?? this.note,
      time: time ?? this.time,
      date: date ?? this.date,
      isCompleted: isComplete ?? this.isCompleted,
      category:  category ?? this.category,
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      TaskKeys.id: id,
      TaskKeys.title: title,
      TaskKeys.note: note,
      TaskKeys.time: time,
      TaskKeys.date: date,
      TaskKeys.category: category.name,
      TaskKeys.isCompleted: isCompleted ? 1 : 0,
    };
  }

  factory Task.fromJson(Map<String, dynamic> map) {
    return Task(
      id: map[TaskKeys.id],
      title: map[TaskKeys.title],
      note: map[TaskKeys.note],
      time: map[TaskKeys.time],
      date: map[TaskKeys.date], 
      category: TaskCategories.stringToCategory(map[TaskKeys.category]),
      isCompleted: map[TaskKeys.isCompleted] == 1 ? true : false,
    );
  }


  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();

//</editor-fold>
}
