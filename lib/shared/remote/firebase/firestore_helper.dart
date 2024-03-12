

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:todo_c10_maadi/layout/home/widgets/task_widget.dart';

import '../../../model/task.dart';
import '../../../model/user.dart';

class FirestoreHelper{
  static CollectionReference<User> getUsersCollection(){
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
  static Future<void> AddUser(String email , String fullname,String userID)async{
    var document = getUsersCollection().doc(userID);
    await document.set(
      User(
          id: userID,
          email: email,
          fullname: fullname
      )
    );

  }

  static Future<User?> GetUser(String userID)async{
    var document = getUsersCollection().doc(userID);

    var snapshot = await document.get();
    User? user = snapshot.data();
    return user;
  }

  static CollectionReference<Task> getTaskCollection(String userId){
    var tasksCollection = getUsersCollection().doc(userId).collection("tasks").withConverter(
        fromFirestore: (snapshot,options)=>Task.fromFirestore(snapshot.data()??{}),
        toFirestore: (task, options)=>task.toFirestore()
    );
    return tasksCollection;
  }

  static Future<void> AddNewTask(Task task,String userId)async{
    var reference = getTaskCollection(userId);
    var taskDocument = reference.doc();
    task.id = taskDocument.id;
    await taskDocument.set(task);
  }

  static Future<List<Task>> GetAllTasks(String uid)async{
    var taskQuery = await getTaskCollection(uid).get();
    List<Task> tasksList = taskQuery.docs.map((snapshot) => snapshot.data()).toList();

    return tasksList;

  }
  static Stream<List<Task>> ListenToTasks(String uid,int date)async*{
    Stream<QuerySnapshot<Task>> taskQueryStream = getTaskCollection(uid).where("date",isEqualTo: date).snapshots();
    Stream<List<Task>> tasksStream =  taskQueryStream.map((querySnapShot) => querySnapShot.docs.map((document) => document.data()).toList());
    yield* tasksStream;
  }
  static Future<void> deleteTask({required String uid ,required String taskId })async{
    await getTaskCollection(uid).doc(taskId).delete();
    print(uid );
    print(taskId);
  }

  static Future<void> updateTask(String userId, String taskId, Task updatedTask) async {
    var ref = getTaskCollection(userId);
    var taskDoc = ref.doc(taskId);
    await taskDoc.update(updatedTask.toFirestore());
  }

}