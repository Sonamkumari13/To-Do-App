import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:to_do_list/data/task.dart';
import 'package:to_do_list/repositories/repositories.dart';
import 'package:to_do_list/task/task.dart';

class TaskNotifier extends StateNotifier<TaskState> {
  final TaskRepository _repository;

  TaskNotifier(this._repository): super( TaskState.initial()) {
    getTasks();
  }

  Future<void> createTask(Task task) async {
    try {
      await _repository.createTask(task);
      getTasks();
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future<void> updateTask(Task task) async {
    try {
      final isCompleted = !task.isCompleted;
      final updatedTask = task.copyWith(isComplete: isCompleted);
      await _repository.updateTask(updatedTask);
      state = state.copyWith(
        tasks: [
          for (final t in state.tasks)
            if (t.id == task.id) updatedTask else t,
        ],
      );
      getTasks();
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future<void> deleteTask(Task task) async {
    try {
      await _repository.deleteTask(task);
      getTasks();
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  void getTasks() async {
    try {
      final tasks = await _repository.getAllTask();
      state = state.copyWith(tasks: tasks);
    }
    catch (e) {
      debugPrint(e.toString());
    }
  }
}