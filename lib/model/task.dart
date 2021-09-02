class Task{
  int? id;
  String? description;
  String? dueDate;
  String completed = "false";

  Task();

  Task.mapToTask(Map<String, dynamic> inMap){
    this.id = inMap['id'];
    this.description = inMap['description'];
    this.dueDate = inMap['dueDate'];
    this.completed = inMap['completed'];
  }

  taskToMap(){
    Map<String, dynamic> outMap = {
      'description' : this.description,
      'dueDate' : this.dueDate,
      'completed' : this.completed
    };

    if(this.id != null){
      outMap['id'] = this.id;
    }

    return outMap;
  }
}