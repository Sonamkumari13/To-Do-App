import 'package:to_do_list/data/data.dart';

abstract class TaskRepository{
  Future<void> createTask(Task task);
  Future<void> updateTask(Task task);
  Future<void> deleteTask(Task task);
  Future<List<Task>> getAllTask();
}