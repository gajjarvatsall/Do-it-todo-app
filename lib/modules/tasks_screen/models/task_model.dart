class TaskModel {
  bool? isCompleted;
  String? userId;
  String? task;

  TaskModel({this.isCompleted, this.userId, this.task});

  TaskModel.fromJson(Map<String, dynamic> json) {
    isCompleted = json['isCompleted'];
    userId = json['userId'];
    task = json['task'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['isCompleted'] = this.isCompleted;
    data['userId'] = this.userId;
    data['task'] = this.task;
    return data;
  }
}
