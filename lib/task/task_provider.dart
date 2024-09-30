import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:to_do_list/task/task.dart';
import 'package:to_do_list/repositories/repositories.dart';

final taskProvider = StateNotifierProvider<TaskNotifier, TaskState>((ref) {
  final _repository = ref.watch(taskRepositoryProvider);
  return TaskNotifier(_repository);
});