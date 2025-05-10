import 'package:al_mullah_asignment/features/dashboard/cubit/task_cubit.dart';
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
      appBar: AppBar(
        title: Text("Add Task"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Text Field for Task Description
            TextField(
              controller: taskController,
              decoration: InputDecoration(
                labelText: 'Enter Task',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16),

            // Text Field for DateTime picker
            TextField(
              controller: dateController,
              decoration: InputDecoration(
                labelText: 'Select Date & Time',
                border: OutlineInputBorder(),
              ),
              readOnly: true,
              onTap: () {
                // Open Date Picker
                _selectDate(context);
              },
            ),
            SizedBox(height: 16),

            // Save and Clear buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  onPressed: () {
                    if (taskController.text.isNotEmpty &&
                        selectedDateTime != null) {
                      // Add task via Cubit
                      context
                          .read<TaskCubit>()
                          .addTask(taskController.text, selectedDateTime!);
                      Navigator.pop(context);
                    } else {
                      // Show a snack bar or error message if validation fails
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                            content:
                                Text("Please enter both task and date/time")),
                      );
                    }
                  },
                  child: Text("Save Task"),
                ),
                ElevatedButton(
                  onPressed: () {
                    // Clear both text fields
                    taskController.clear();
                    dateController.clear();
                    setState(() {
                      selectedDateTime = null;
                    });
                  },
                  child: Text("Clear"),
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
