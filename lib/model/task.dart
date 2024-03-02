class Task {
  String? id;
  String? title;
  String? description;
  int? date;
  Task({required this.title ,this.id, required this.date , required this.description});

  Task.fromFirestore(Map<String , dynamic> data){
    id = data['id'];
    title = data["title"];
    description = data["description"];
    date = data["date"];
  }
  Map<String, dynamic> toFirestore(){
    Map<String , dynamic> data = {
      "title":title,
      "description":description,
      "date":date,
      "id":id
    };
    return data;
  }
}