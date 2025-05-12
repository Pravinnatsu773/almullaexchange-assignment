import 'package:al_mullah_asignment/common/common_button.dart';
import 'package:al_mullah_asignment/constants/strings.dart';
import 'package:al_mullah_asignment/features/dashboard/cubit/task_cubit.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddTaskPage extends StatefulWidget {
  @override
  _AddTaskPageState createState() => _AddTaskPageState();
}

class _AddTaskPageState extends State<AddTaskPage> {
  final TextEditingController taskController = TextEditingController();
  final TextEditingController dateController = TextEditingController();

  DateTime? selectedDateTime;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: taskController,
              decoration: InputDecoration(
                labelText: AppStrings.taskName.tr(),
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16),
            TextField(
              controller: dateController,
              decoration: InputDecoration(
                labelText: AppStrings.dateTime.tr(),
                border: OutlineInputBorder(),
              ),
              readOnly: true,
              onTap: () {
                _selectDate(context);
              },
            ),
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CommonButton(
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  text: AppStrings.save.tr(),
                  onTap: () {
                    if (taskController.text.isNotEmpty &&
                        selectedDateTime != null) {
                      context
                          .read<TaskCubit>()
                          .addTask(taskController.text, selectedDateTime!);
                      Navigator.pop(context);
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                            content:
                                Text("Please enter both task and date/time")),
                      );
                    }
                  },
                ),
                CommonButton(
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  text: AppStrings.clear.tr(),
                  onTap: () {
                    // Clear both text fields
                    taskController.clear();
                    dateController.clear();
                    setState(() {
                      selectedDateTime = null;
                    });
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // Function to pick date and time
  Future<void> _selectDate(BuildContext context) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );

    if (pickedDate != null) {
      // After date is selected, pick the time
      _selectTime(context, pickedDate);
    }
  }

  // Function to pick time
  Future<void> _selectTime(BuildContext context, DateTime pickedDate) async {
    TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.fromDateTime(DateTime.now()),
    );

    if (pickedTime != null) {
      setState(() {
        // Combine picked date and time into a single DateTime object
        selectedDateTime = DateTime(
          pickedDate.year,
          pickedDate.month,
          pickedDate.day,
          pickedTime.hour,
          pickedTime.minute,
        );
        dateController.text =
            "${selectedDateTime!.toLocal()}"; // Format it as per your requirement
      });
    }
  }
}
