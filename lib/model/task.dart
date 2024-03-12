class Task {
  String? id;
  String? title;
  String? description;
  int? date;
  bool? isDone;
  Task({required this.title ,this.id, required this.date , required this.description,this.isDone = false});

  Task.fromFirestore(Map<String , dynamic> data){
    id = data['id'];
    title = data["title"];
    description = data["description"];
    date = data["date"];
    isDone = data['isDone'];
  }
  Map<String, dynamic> toFirestore(){
    Map<String , dynamic> data = {
      "title":title,
      "description":description,
      "date":date,
      "id":id,
      "isDone":isDone
    };
    return data;
  }
}