import 'package:flutter/material.dart';
import 'package:to_do_list/data/task.dart';
import 'package:to_do_list/task/task.dart';
import 'package:to_do_list/utils/app_alerts.dart';
import 'package:to_do_list/utils/utils.dart';
import 'package:to_do_list/widgets/widget.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DisplayListOfTask extends ConsumerWidget{
  const DisplayListOfTask({
    super.key,
    required this.tasks,
    this.isCompletedTasks = false});

  final List<Task> tasks;
  final bool isCompletedTasks;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final deviceSize = context.deviceSize;
    final height = isCompletedTasks ? deviceSize.height * 0.25 : deviceSize.height * 0.3;
    final emptyTaskMessage = isCompletedTasks ? 'There is no completed task yet' : 'There is no task todo';

    return CommonContainer(
      height: height,
      child : tasks.isEmpty
          ? Center(
              child: Text(
                emptyTaskMessage,
                style: context.textTheme.headlineSmall,
              ),
            )
          :ListView.separated(
          shrinkWrap: true,
          itemCount: tasks.length,
          padding: EdgeInsets.zero,
          itemBuilder: (ctx, index){
            final task = tasks[index];

            return InkWell(
              onLongPress: (){
                AppAlerts.showDeleteAlertDialog(context, ref, task);
              },
                onTap: () async{
                  await showModalBottomSheet(
                      context: context,
                      builder: (ctx){
                        return TaskDetails(task: task);
                  });
                },
                child: TaskTile(
                  task: task,
                  onCompleted: (value) async{
                    await ref
                        .read(taskProvider.notifier)
                        .updateTask(task)
                        .then((value) {
                          AppAlerts.displaySnackBar(
                              context,
                              task.isCompleted
                                  ? 'Task incompleted'
                                  : 'Task completed'
                          );
                        }
                    );
                },
                )
            );
          }, separatorBuilder: (BuildContext context, int index) {
            return const Divider(thickness: 1.5,);
      },),
    );
  }
}

