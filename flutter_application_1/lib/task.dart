class Task {
  final String id;
  final String title;
  final String description;
  final bool isCompleted;
  final DateTime createdAt;
  final String priority;
  final DateTime? deadline;

  Task({
    required this.id,
    required this.title,
    required this.description,
    this.isCompleted = false,
    required this.createdAt,
    this.priority = 'Medium',
    this.deadline,
  });

  // Convert to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'isCompleted': isCompleted,
      'createdAt': createdAt.toIso8601String(),
      'priority': priority,
      'deadline': deadline?.toIso8601String(),
    };
  }

  // Create from JSON
  factory Task.fromJson(Map<String, dynamic> json) {
    return Task(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      isCompleted: json['isCompleted'] ?? false,
      createdAt: DateTime.parse(json['createdAt']),
      priority: json['priority'] ?? 'Medium',
      deadline: json['deadline'] != null ? DateTime.parse(json['deadline']) : null,
    );
  }

  Task copyWith({
    String? id,
    String? title,
    String? description,
    bool? isCompleted,
    DateTime? createdAt,
    String? priority,
    DateTime? deadline,
  }) {
    return Task(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      isCompleted: isCompleted ?? this.isCompleted,
      createdAt: createdAt ?? this.createdAt,
      priority: priority ?? this.priority,
      deadline: deadline ?? this.deadline,
    );
  }
}