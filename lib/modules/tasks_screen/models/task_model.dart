class TaskModel {
  bool? isCompleted;
  String? userId;
  String? id;
  String? task;

  TaskModel({this.isCompleted, this.userId, this.id, this.task});

  TaskModel.fromJson(Map<String, dynamic> json) {
    isCompleted = json['isCompleted'];
    userId = json['userId'];
    id = json['id'];
    task = json['task'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['isCompleted'] = this.isCompleted;
    data['userId'] = this.userId;
    data['id'] = this.id;
    data['task'] = this.task;
    return data;
  }
}
