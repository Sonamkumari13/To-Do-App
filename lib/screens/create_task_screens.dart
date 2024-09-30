import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:to_do_list/data/data.dart';
import 'package:to_do_list/providers/providers.dart';
import 'package:to_do_list/task/task.dart';
import 'package:to_do_list/utils/helpers.dart';
import 'package:to_do_list/utils/app_alerts.dart';
import 'package:to_do_list/widgets/widget.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:to_do_list/routes/routes.dart';
import '../routes/route_location.dart';

class CreateTaskScreen extends ConsumerStatefulWidget{
  static CreateTaskScreen builder(BuildContext context,
      GoRouterState state) => const CreateTaskScreen();
  const CreateTaskScreen({super.key});

  @override
  ConsumerState<CreateTaskScreen> createState() => _CreateTaskScreenState();
}

class _CreateTaskScreenState extends ConsumerState<CreateTaskScreen> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _noteController = TextEditingController();

  @override
  void dispose() {
    _titleController.dispose();
    _noteController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: DisplayWhiteText(
            text: 'Add New Task'
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          padding: EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              CommonTextField(
                title: 'Task Title',
                hintText: 'Task Title',
                controller: _titleController,
              ),
              const Gap(16),
              const SelectCategory(),
              const Gap(16),
              const SelectDateTime(),
              const Gap(16),
              CommonTextField(
                title: 'Note',
                hintText: 'Take Note',
                maxLines: 7,
                controller: _noteController,
              ),
              const Gap(70),
              ElevatedButton(
                  onPressed: _createTask,
                  child: DisplayWhiteText(text: 'Save'))
            ],
          ),
        ),
      ),
    );
  }

  void _createTask() async {
      final title = _titleController.text.trim();
      final note = _noteController.text.trim();
      final date = ref.watch(dateProvider);
      final time = ref.watch(timeProvider);
      final category = ref.watch(categoryProvider);

      if (title.isNotEmpty) {
        final task = Task(
            title: title,
            note: note,
            time: Helpers.timeToString(time),
            date: DateFormat.yMMMd().format(date),
            category: category,
            isCompleted: false
        );

        await ref.read(taskProvider.notifier).createTask(task).then((value) {
          AppAlerts.displaySnackBar(context, 'Task Created Sucessfully');
          context.go(RouteLocation.home);
        });
      }
      else {
        AppAlerts.displaySnackBar(context, 'Task Title cannot be Empty');
        context.go(RouteLocation.home);
      }
  }
}