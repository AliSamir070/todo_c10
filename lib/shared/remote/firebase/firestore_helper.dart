import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

import '../../../model/user.dart';

class FirestoreHelper{
  CollectionReference<User> getUsersCollection(){
    var reference = FirebaseFirestore.instance.collection("User").withConverter(
        fromFirestore: (snapshot,options){
          Map<String, dynamic>? data = snapshot.data();
          return User.fromFirestore(data??{});
        },
        toFirestore:(user, options){
          return user.toFirestore();
        }
    );
    return reference;
  }
  AddUser(String email , String fullname,String userID)async{
    var document = getUsersCollection().doc(userID);
    await document.set(
      User(
          id: userID,
          email: email,
          fullname: fullname
      )
    );

  }

  Future<User?> GetUser(String userID)async{
    var document = getUsersCollection().doc(userID);

    var snapshot = await document.get();
    User? user = snapshot.data();
    return user;
  }
}