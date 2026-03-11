import 'dart:convert';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'task.dart';

class StorageService {
  static Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  static Future<File> get _localFile async {
    final path = await _localPath;
    return File('$path/tasks.json');
  }

  static Future<List<Task>> loadTasks() async {
    try {
      final file = await _localFile;
      if (await file.exists()) {
        final contents = await file.readAsString();
        final List<dynamic> jsonData = jsonDecode(contents);
        return jsonData.map((json) => Task.fromJson(json)).toList();
      }
    } catch (e) {
      // If encountering an error, return empty list
    }
    return [];
  }

  static Future<void> saveTasks(List<Task> tasks) async {
    final file = await _localFile;
    final jsonData = tasks.map((task) => task.toJson()).toList();
    await file.writeAsString(jsonEncode(jsonData));
  }
}