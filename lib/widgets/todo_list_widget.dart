import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:test6/utils/app_theme.dart';

class TodoListWidget extends StatefulWidget {
  const TodoListWidget({super.key});

  @override
  State<TodoListWidget> createState() => _TodoListWidgetState();
}

class _TodoListWidgetState extends State<TodoListWidget> {
  // Mock todo data (replace with actual data from SQLite later)
  final List<Map<String, dynamic>> _todos = [
    {
      'id': 1,
      'title': 'Complete project proposal',
      'deadline': DateTime.now().add(const Duration(hours: 3)),
      'isCompleted': false,
    },
    {
      'id': 2,
      'title': 'Schedule team meeting',
      'deadline': DateTime.now().add(const Duration(hours: 5)),
      'isCompleted': true,
    },
    {
      'id': 3,
      'title': 'Prepare presentation',
      'deadline': DateTime.now().add(const Duration(hours: 8)),
      'isCompleted': false,
    },
  ];

  String _getRemainingTime(DateTime deadline) {
    final now = DateTime.now();
    final difference = deadline.difference(now);

    if (difference.isNegative) {
      return 'Overdue';
    } else if (difference.inDays > 0) {
      return '${difference.inDays}d left';
    } else if (difference.inHours > 0) {
      return '${difference.inHours}h left';
    } else if (difference.inMinutes > 0) {
      return '${difference.inMinutes}m left';
    } else {
      return 'Now';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ReorderableListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: _todos.length,
          onReorder: (oldIndex, newIndex) {
            setState(() {
              if (oldIndex < newIndex) {
                newIndex -= 1;
              }
              final item = _todos.removeAt(oldIndex);
              _todos.insert(newIndex, item);
            });
          },
          itemBuilder: (context, index) {
            final todo = _todos[index];
            return Slidable(
              key: ValueKey(todo['id']),
              endActionPane: ActionPane(
                motion: const ScrollMotion(),
                children: [
                  SlidableAction(
                    onPressed: (context) {
                      // Delete item (to be implemented)
                    },
                    backgroundColor: Colors.red,
                    foregroundColor: Colors.white,
                    icon: Icons.delete,
                    label: 'Delete',
                  ),
                ],
              ),
              child: ListTile(
                leading: ReorderableDragStartListener(
                  index: index,
                  child: const Icon(Icons.drag_handle, color: Colors.grey),
                ),
                title: Text(
                  todo['title'],
                  style: TextStyle(
                    decoration:
                        todo['isCompleted'] ? TextDecoration.lineThrough : null,
                    color:
                        todo['isCompleted'] ? Colors.grey : AppTheme.textColor,
                  ),
                ),
                subtitle: Text(_getRemainingTime(todo['deadline'])),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Checkbox(
                      value: todo['isCompleted'],
                      activeColor: AppTheme.primaryColor,
                      onChanged: (value) {
                        setState(() {
                          todo['isCompleted'] = value;
                        });
                      },
                    ),
                    IconButton(
                      icon: const Icon(Icons.more_vert),
                      onPressed: () {
                        // Show edit dialog (to be implemented)
                        _showEditTodoDialog(context, todo);
                      },
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  void _showEditTodoDialog(BuildContext context, Map<String, dynamic> todo) {
    final TextEditingController titleController = TextEditingController(
      text: todo['title'],
    );
    final TextEditingController detailsController = TextEditingController();
    DateTime selectedDate = todo['deadline'];
    TimeOfDay selectedTime = TimeOfDay.fromDateTime(todo['deadline']);

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Edit Task'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: titleController,
                  decoration: const InputDecoration(
                    labelText: 'Task Title',
                    hintText: 'Enter task title',
                  ),
                ),
                const SizedBox(height: 16),
                InkWell(
                  onTap: () async {
                    final DateTime? pickedDate = await showDatePicker(
                      context: context,
                      initialDate: selectedDate,
                      firstDate: DateTime.now(),
                      lastDate: DateTime.now().add(const Duration(days: 365)),
                    );
                    if (pickedDate != null) {
                      setState(() {
                        selectedDate = pickedDate;
                      });
                    }
                  },
                  child: InputDecorator(
                    decoration: const InputDecoration(
                      labelText: 'Deadline Date',
                    ),
                    child: Text(
                      '${selectedDate.year}-${selectedDate.month}-${selectedDate.day}',
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                InkWell(
                  onTap: () async {
                    final TimeOfDay? pickedTime = await showTimePicker(
                      context: context,
                      initialTime: selectedTime,
                    );
                    if (pickedTime != null) {
                      setState(() {
                        selectedTime = pickedTime;
                      });
                    }
                  },
                  child: InputDecorator(
                    decoration: const InputDecoration(
                      labelText: 'Deadline Time',
                    ),
                    child: Text('${selectedTime.hour}:${selectedTime.minute}'),
                  ),
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: detailsController,
                  maxLines: 3,
                  decoration: const InputDecoration(
                    labelText: 'Details',
                    hintText: 'Enter task details',
                  ),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                // Update todo item (to be implemented)
                setState(() {
                  todo['title'] = titleController.text;
                  // Update other fields as needed
                });
                Navigator.of(context).pop();
              },
              child: const Text('Save'),
            ),
          ],
        );
      },
    );
  }
}
