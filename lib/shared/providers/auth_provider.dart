import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:todo_c10_maadi/model/user.dart' as MyUser;
import 'package:todo_c10_maadi/shared/remote/firebase/firestore_helper.dart';

class Authprovider extends ChangeNotifier{

  User? firebaseUserAuth;
  MyUser.User? databaseUser;

  void setUsers(User? newFirebaseUserAuth , MyUser.User? newDatabaseUser){
    firebaseUserAuth = newFirebaseUserAuth;
    databaseUser = newDatabaseUser;
  }

  bool isFirebaseUserLoggedIn(){
    if(FirebaseAuth.instance.currentUser == null) return false;

    firebaseUserAuth = FirebaseAuth.instance.currentUser;
    return true;
}

  Future<void> retrieveDatabaseUserData()async{
    try{
      databaseUser = await FirestoreHelper.GetUser(firebaseUserAuth!.uid);
    }catch(error){
      print(error);
    }
  }

  Future<void> SignOut()async{
    firebaseUserAuth = null;
    databaseUser = null;
    return await FirebaseAuth.instance.signOut();
  }

}