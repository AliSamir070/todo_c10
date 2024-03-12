
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_c10_maadi/shared/reusable_componenets/custom_form_field.dart';
import '../../model/task.dart';
import '../../shared/remote/firebase/firestore_helper.dart';
import '../home/provider/home_provider.dart';

class EditTaskScreen extends StatefulWidget {
  EditTaskScreen({super.key});
  static const String routeName = "EditTaskScreen";

  DateTime? selectDate;
  @override
  State<EditTaskScreen> createState() => _EditTaskScreenState();
}

class _EditTaskScreenState extends State<EditTaskScreen> {
  final  TextEditingController titleController = TextEditingController();
  final TextEditingController descController = TextEditingController();

  @override
  @override
  void initState() {
    super.initState();
    Task? task = ModalRoute.of(context)?.settings.arguments as Task?;
    if (task != null) {
      titleController.text = task.title ?? '';
      descController.text = task.description ?? '';
    }
  }

  @override
  Widget build(BuildContext context) {
    HomeProvider provider = Provider.of<HomeProvider>(context);

    Task task=ModalRoute.of(context)?.settings.arguments as Task;

    return Scaffold(
        appBar: AppBar(
          title: Text("Edit Task Screeen"),
        ),
        body: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(15)),
              color: Colors.white),
          padding: EdgeInsets.all(15),
          margin: EdgeInsets.all(20),


            child: Column(
              children: [
                CustomFormField(
                  controller: titleController,
                  label: "Enter task title",
                  keyboard: TextInputType.text,

                ),
                SizedBox(height: 10,),
                CustomFormField(
                  maxLInes: 2,
                  controller: descController,
                  label: "Enter task description",
                  keyboard: TextInputType.multiline,

                ),
                SizedBox(height: 20,),

                InkWell(
                  onTap: ()async{
                    DateTime? selectedDate = await showDatePicker(
                        context: context,
                        firstDate: DateTime.now(),
                        lastDate: DateTime.now().add(Duration(days: 365)),
                        initialDate: DateTime.now()
                    );
                    provider.selectNewDate(selectedDate);
                    setState(() {
                    });
                  },
                  child: Text(
                    provider.selectedDate==null?"Select Date"
                        :"${provider.selectedDate?.day} / ${provider.selectedDate?.month} / ${provider.selectedDate?.year}",
                    style: Theme.of(context).textTheme.labelMedium?.copyWith(
                        fontSize: 20,
                        fontWeight: FontWeight.w400
                    ),),
                ),
                SizedBox(height:20),
                ElevatedButton(
                    onPressed: (){
                      var userId =FirebaseAuth.instance.currentUser!.uid;
                      task.id = task.id;
                      task.title = titleController.text;
                      task.description = descController.text;
                      task.date= 2;
                      Task updatedTask =Task(title: task.title, description: task.description,
                          date: task.date,id: task.id);

                      FirestoreHelper.updateTask(userId, task.id!, updatedTask);
                      Navigator.pop(context);

                    }, child: Text("Edit")),
                SizedBox(height: 20,),
              ],
            ),
          ),
        );
  }
}
