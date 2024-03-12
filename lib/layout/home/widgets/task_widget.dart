import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:todo_c10_maadi/shared/remote/firebase/firestore_helper.dart';

import '../../../model/task.dart';
import '../../../shared/providers/auth_provider.dart';

class TaskWidget extends StatelessWidget {
  Task task;
  TaskWidget({required this.task});

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    DateTime taskDate = DateTime.fromMillisecondsSinceEpoch(task.date??0);
    print(taskDate.toString());
    Authprovider provider = Provider.of<Authprovider>(context);
    return Slidable(
      startActionPane: ActionPane(
          motion:ScrollMotion() ,
          extentRatio: 0.3,
          children: [
                SlidableAction(
                    onPressed: (context){
                      FirestoreHelper.deleteTask(uid: provider.firebaseUserAuth!.uid, taskId: task.id??"");
                    },
                    icon: Icons.delete,
                    label: "Delete",
                    backgroundColor: Colors.redAccent,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(15),
                      bottomLeft: Radius.circular(15)
                    ),
                )
          ]),
      child: Container(
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15)
        ),
        child: Row(
          children: [
            Container(
              height: height * 0.1,
              width: 4,
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                borderRadius: BorderRadius.circular(10)
              ),
            ),
            SizedBox(width: 10,),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    task.title??"",
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  SizedBox(height: 5,),
                  Row(
                    children: [
                      Icon(
                        Icons.access_time_outlined,
                        color: Colors.black,
                        size: 20,
                      ),
                      SizedBox(width: 5,),
                      Text(
                      "${DateFormat.jm().format(taskDate)}",
                        style: Theme.of(context).textTheme.titleSmall,
                      )
                    ],
                  )
                ],
              ),
            ),
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)
                  )
                ),
                onPressed: (){

            }, child: Icon(
              Icons.check
            ))
          ],
        ),
      ),
    );
  }
}
