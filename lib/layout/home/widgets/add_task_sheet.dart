import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_c10_maadi/layout/home/provider/home_provider.dart';
import 'package:todo_c10_maadi/shared/reusable_componenets/custom_form_field.dart';

class AddTaskSheet extends StatefulWidget {
  void Function() onCancel;
  TextEditingController titleController;
  TextEditingController descController;
  GlobalKey<FormState> formKey;
  AddTaskSheet({required this.onCancel,required this.formKey , required this.titleController , required this.descController});
  @override
  State<AddTaskSheet> createState() => _AddTaskSheetState();
}

class _AddTaskSheetState extends State<AddTaskSheet> {


  @override
  Widget build(BuildContext context) {
    HomeProvider provider = Provider.of<HomeProvider>(context);
    return Material(
      color: Colors.transparent,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20)
        ),
        child:Form(
          key: widget.formKey,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text("Add New Task",style: Theme.of(context).textTheme.labelMedium,),
                SizedBox(height: 20,),
                CustomFormField(
                    controller: widget.titleController,
                    label: "Enter task title",
                    keyboard: TextInputType.text,
                  validator: (value){
                      if(value==null || value.isEmpty){
                        return "Title can't be empty";
                      }
                      return null;
                  },
                ),
                SizedBox(height: 10,),
                CustomFormField(
                  maxLInes: 2,
                  controller: widget.descController,
                  label: "Enter task description",
                  keyboard: TextInputType.multiline,
                  validator: (value){
                    if(value==null || value.isEmpty){
                      return "Description can't be empty";
                    }
                    return null;
                  },
                ),
                SizedBox(height: 10,),
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
                SizedBox(height: 20,),
                ElevatedButton(
                    onPressed: (){
                      Navigator.pop(context);
                      widget.onCancel();
                    }, child: Text("Cancel")),
                SizedBox(height: 20,),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
