import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:to_do_list_app/models/task_model.dart';

class AddTaskModal extends StatefulWidget {
  final Function(Task) onAddTask;

  const AddTaskModal({super.key, required this.onAddTask});

  @override
  State<AddTaskModal> createState() => _AddTaskModalState();
}

class _AddTaskModalState extends State<AddTaskModal> {
  final _titleController = TextEditingController();
  final _dateController = TextEditingController();
  DateTime? _selectedDate;
  Priority _selectedPriority = Priority.low;

  final List<String> _selectedTags = ['Work', 'Personal'];

  final _tagController = TextEditingController();
  bool _isAddingTag = false;

  void _pickDate() async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: Color(0xFF007AFF),
              onPrimary: Colors.white,
            ),
          ),
          child: child!,
        );
      },
    );
    if (picked != null) {
      setState(() {
        _selectedDate = picked;
        _dateController.text = DateFormat('MM/dd/yyyy').format(picked);
      });
    }
  }

  void _submitTask() {
    final title = _titleController.text.trim();
    if (title.isEmpty) {
      return;
    }
    final newTask = Task(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      title: title,
      priority: _selectedPriority,
      date: _selectedDate,
      tags: _selectedTags,
    );
    widget.onAddTask(newTask);
    Navigator.pop(context);
  }

  Widget _buildPriorityButton(Priority priority, String label) {
    final bool isSelected = (_selectedPriority == priority);

    Color backgroundColor;
    Color textColor;

    if (isSelected) {
      if (priority == Priority.low) {
        backgroundColor = const Color(0xFFCFF7D3);
        textColor = const Color(0xFF34C759);
      } else if (priority == Priority.medium) {
        backgroundColor = const Color(0xFFFF9500).withOpacity(0.2);
        textColor = const Color(0xFFFF9500);
      } else {
        backgroundColor = const Color(0xFFFF3B30).withOpacity(0.2);
        textColor = const Color(0xFFFF3B30);
      }
    } else {
      backgroundColor = const Color(0xFFFFFFFF);
      textColor = const Color(0xFF000000);
    }

    return Expanded(
      child: TextButton(
        onPressed: () {
          setState(() {
            _selectedPriority = priority;
          });
        },
        style: TextButton.styleFrom(
          backgroundColor: backgroundColor,
          foregroundColor: textColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
            side: isSelected
                ? BorderSide.none
                : const BorderSide(color: Color(0xffD9D9D9), width: 1.0),
          ),
          fixedSize: const Size.fromHeight(38),
        ),
        child: Text(label, style: const TextStyle(fontWeight: FontWeight.w600)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    const TextStyle labelStyle = TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w600,
      color: Color(0xff1E1E1E),
    );

    return Padding(
      padding: EdgeInsets.all(16),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                width: 70,
                height: 4,
                decoration: BoxDecoration(
                  color: const Color(0xffD9D9D9),
                  borderRadius: BorderRadius.circular(99),
                ),
              ),
            ),
            const SizedBox(height: 36),
            const Text(
              'Add Task',
              textAlign: TextAlign.left,
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w600,
                color: Color(0xff090909),
              ),
            ),
            const SizedBox(height: 18),
            const Text(
              'What do you want to do ?',
              textAlign: TextAlign.left,
              style: labelStyle,
            ),
            const SizedBox(height: 8),
            TextField(
              controller: _titleController,
              decoration: InputDecoration(
                hintText: 'e.g. Finish design system',
                hintStyle: const TextStyle(color: Color(0xffB3B3B3)),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(color: Color(0xffD9D9D9)),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(color: Color(0xFF007AFF)),
                ),
              ),
            ),
            const SizedBox(height: 18),
            const Text('Date', textAlign: TextAlign.left, style: labelStyle),
            const SizedBox(height: 8),
            TextField(
              controller: _dateController,
              readOnly: true,
              decoration: InputDecoration(
                hintText: 'mm/dd/yyyy',
                hintStyle: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: Color(0xff121212),
                ),
                suffixIcon: IconButton(
                  icon: const Icon(
                    Icons.calendar_month_outlined,
                    color: Color(0xff888888),
                  ),
                  onPressed: _pickDate,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(color: Color(0xffE3E3E3)),
                ),
              ),
              onTap: _pickDate,
            ),
            const SizedBox(height: 18),
            const Text('Priority', style: labelStyle),
            const SizedBox(height: 8),
            Row(
              children: [
                _buildPriorityButton(Priority.low, 'Low'),
                const SizedBox(width: 8),
                _buildPriorityButton(Priority.medium, 'Medium'),
                const SizedBox(width: 8),
                _buildPriorityButton(Priority.high, 'High'),
              ],
            ),
            const SizedBox(height: 18),
            const Text('Tags', style: labelStyle),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8.0,
              runSpacing: 8.0,
              children: [
                ..._selectedTags.map((tag) {
                  return Chip(
                    label: Text(tag),
                    labelStyle: const TextStyle(
                      color: Color(0xFF34C759),
                      fontWeight: FontWeight.w700,
                    ),
                    backgroundColor: const Color(0xFFCFF7D3),
                    deleteIcon: const Icon(Icons.close, size: 18),
                    deleteIconColor: const Color(0xFF34C759),
                    onDeleted: () {
                      setState(() {
                        _selectedTags.remove(tag);
                      });
                    },
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                      side: const BorderSide(color: Colors.transparent),
                    ),
                  );
                }).toList(),
                if (_isAddingTag)
                  SizedBox(
                    width: 100,
                    height: 38,
                    child: TextField(
                      controller: _tagController,
                      autofocus: true,
                      style: const TextStyle(fontSize: 14),
                      decoration: InputDecoration(
                        hintText: 'tag name',
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 8,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(
                            color: Color(0xFF007AFF),
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(
                            color: Color(0xFF007AFF),
                            width: 2,
                          ),
                        ),
                      ),
                      onSubmitted: (value) {
                        if (value.isNotEmpty) {
                          setState(() {
                            _selectedTags.add(value);
                          });
                        }
                        _tagController.clear();
                        setState(() {
                          _isAddingTag = false;
                        });
                      },
                    ),
                  )
                else
                  ActionChip(
                    avatar: const Icon(
                      Icons.add,
                      size: 18,
                      color: Color(0xFF333333),
                    ),
                    label: const Text('Add Tags'),
                    labelStyle: const TextStyle(
                      color: Color(0xFF333333),
                      fontWeight: FontWeight.w500,
                    ),
                    backgroundColor: const Color(0xFFF5F5F5),
                    onPressed: () {
                      setState(() {
                        _isAddingTag = true;
                      });
                    },
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                      side: const BorderSide(color: Colors.transparent),
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 32),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _submitTask,
                style: ElevatedButton.styleFrom(
                  fixedSize: Size(358, 54),
                  backgroundColor: const Color(0xFF007AFF),
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(100),
                  ),
                ),
                child: const Text(
                  'Add Task',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
                ),
              ),
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}
