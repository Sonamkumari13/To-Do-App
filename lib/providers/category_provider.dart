import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:to_do_list/utils/utils.dart';

final categoryProvider = StateProvider.autoDispose<TaskCategories>((ref){
  return TaskCategories.others;
});