import 'dart:io';

class Task {
  String title;
  String description;
  DateTime dueDate;
  bool isCompleted;

  Task({
    required this.title,
    required this.description,
    required this.dueDate,
    this.isCompleted = false,
  });

  @override
  String toString() {
    return 'Title: $title\nDescription: $description\nDue Date: $dueDate\nStatus: ${isCompleted ? 'Completed' : 'Pending'}';
  }
}

class TaskManager {
  List<Task> tasks = [];

  void addTask(Task task) {
    tasks.add(task);
  }

  List<Task> getAllTasks() {
    return tasks;
  }

  List<Task> getCompletedTasks() {
    return tasks.where((task) => task.isCompleted).toList();
  }

  List<Task> getPendingTasks() {
    return tasks.where((task) => !task.isCompleted).toList();
  }

  void editTask(int index, Task updatedTask) {
    if (index >= 0 && index < tasks.length) {
      tasks[index] = updatedTask;
    }
  }

  void deleteTask(int index) {
    if (index >= 0 && index < tasks.length) {
      tasks.removeAt(index);
    }
  }
}

void main() {
  final taskManager = TaskManager();

  while (true) {
    print('Task Manager Menu:');
    print('1. Add Task');
    print('2. View All Tasks');
    print('3. View Completed Tasks');
    print('4. View Pending Tasks');
    print('5. Edit Task');
    print('6. Delete Task');
    print('7. Exit');
    stdout.write('Choose an option: ');
    final choice = stdin.readLineSync();

    switch (choice) {
      case '1':
        stdout.write('Enter title: ');
        final title = stdin.readLineSync()!;
        stdout.write('Enter description: ');
        final description = stdin.readLineSync()!;
        stdout.write('Enter due date (YYYY-MM-DD): ');
        final dueDate = DateTime.parse(stdin.readLineSync()!);
        taskManager.addTask(Task(title: title, description: description, dueDate: dueDate));
        break;
      case '2':
        print('All Tasks:');
        for (var task in taskManager.getAllTasks()) {
          print(task);
          print('---');
        }
        break;
      case '3':
        print('Completed Tasks:');
        for (var task in taskManager.getCompletedTasks()) {
          print(task);
          print('---');
        }
        break;
      case '4':
        print('Pending Tasks:');
        for (var task in taskManager.getPendingTasks()) {
          print(task);
          print('---');
        }
        break;
      case '5':
        stdout.write('Enter task index to edit: ');
        final index = int.parse(stdin.readLineSync()!);
        stdout.write('Enter new title: ');
        final newTitle = stdin.readLineSync()!;
        stdout.write('Enter new description: ');
        final newDescription = stdin.readLineSync()!;
        stdout.write('Enter new due date (YYYY-MM-DD): ');
        final newDueDate = DateTime.parse(stdin.readLineSync()!);
        stdout.write('Is the task completed (yes/no)? ');
        final isCompleted = stdin.readLineSync()!.toLowerCase() == 'yes';
        taskManager.editTask(index, Task(title: newTitle, description: newDescription, dueDate: newDueDate, isCompleted: isCompleted));
        break;
      case '6':
        stdout.write('Enter task index to delete: ');
        final indexToDelete = int.parse(stdin.readLineSync()!);
        taskManager.deleteTask(indexToDelete);
        break;
      case '7':
        print('Exiting...');
        return;
      default:
        print('Invalid option, please try again.');
    }
  }
}
