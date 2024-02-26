class User{
  String? id;
  String? fullname;
  String? email;
  User({required this.id , required this.email , required this.fullname});

  User.fromFirestore(Map<String , dynamic> data){
    id = data['id'];
    fullname = data['fullname'];
    email = data['email'];
  }

  Map<String , dynamic> toFirestore(){
    return {
      "id":id,
      "fullname":fullname,
      "email":email
    };
  }
}
