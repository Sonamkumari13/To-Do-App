import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:to_do_list/data/task.dart';
import 'package:to_do_list/providers/date_provider.dart';
import 'package:to_do_list/routes/route_location.dart';
import 'package:to_do_list/task/task.dart';
import 'package:to_do_list/utils/utils.dart';
import 'package:gap/gap.dart';
import 'package:to_do_list/widgets/widget.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

class HomeScreen extends ConsumerWidget{
  static HomeScreen builder(BuildContext context, GoRouterState state) =>
      const HomeScreen();
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = context.colorScheme;
    final deviceSize = context.deviceSize;
    final taskState = ref.watch(taskProvider);
    final completedTask = _completedTask(taskState.tasks, ref);
    final inCompletedTask = _incompletedTask(taskState.tasks, ref);
    final selectedDate = ref.watch(dateProvider);

    return Scaffold(
      body: Stack(
        children: [
          Column(
            children: [
              Container(
                height: deviceSize.height * 0.3,
                width: deviceSize.width,
                color: colors.primary,
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      InkWell(
                        onTap: () => Helpers.selectDate,
                        child: DisplayWhiteText(
                          text: DateFormat.yMMMd().format(selectedDate),
                          fontWeight: FontWeight.normal,),
                      ),
                      const Gap(10),
                      DisplayWhiteText(
                        text: 'My Todo list',
                        fontWeight: FontWeight.bold,
                        fontSize: 40,)
                    ],
                  ),
                ),
              ),
            ],
          ),
          Positioned(
              top: 130,
              left: 0,
              right: 0,
              child: SafeArea(
                child: Container(
                  height: deviceSize.height-deviceSize.height*0.25,
                  child: SingleChildScrollView(
                    physics:  AlwaysScrollableScrollPhysics(),
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        DisplayListOfTask(
                            tasks:inCompletedTask,
                        ),
                        const Gap(20),
                        Text('Completed',
                        style: context.textTheme.headlineMedium,),
                        const Gap(20),
                        DisplayListOfTask(
                          tasks: completedTask,
                          isCompletedTasks: true,
                        ),
                        const Gap(20),
                        ElevatedButton(onPressed: () => context.push(RouteLocation.createTask),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: DisplayWhiteText(text: "Add New Task"),
                        ))
                      ],
                    ),
                  ),
                ),
              ),
          ),
        ],
      ),
    );
  }
}

List<Task> _completedTask(List<Task> tasks, WidgetRef ref) {
  final selectedDate = ref.watch(dateProvider);
  final List<Task> filteredTasks = [];

  for(var task in tasks) {
    final isTaskDay = Helpers.isTaskFromSelectedDate(task, selectedDate);
    if (task.isCompleted && isTaskDay) {
      filteredTasks.add(task);
    }
  }
  return filteredTasks;
}

List<Task> _incompletedTask(List<Task> tasks, WidgetRef ref) {
  final selectedDate = ref.watch(dateProvider);
  final List<Task> filteredTasks = [];
  for (var task in tasks) {
    final isTaskDay = Helpers.isTaskFromSelectedDate(task, selectedDate);
    if (!task.isCompleted && isTaskDay) {
      filteredTasks.add(task);
    }
  }
  return filteredTasks;
}