import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:to_do_list/repositories/repositories.dart';
import 'package:to_do_list/providers/providers.dart';

final taskRepositoryProvider = Provider<TaskRepository>((ref){
  final _datasource = ref.watch(taskDatasourceProvider);
  return TaskRepositoryImpl(_datasource);
});