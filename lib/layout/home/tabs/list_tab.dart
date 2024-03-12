import 'package:easy_date_timeline/easy_date_timeline.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_c10_maadi/layout/home/widgets/task_widget.dart';
import 'package:todo_c10_maadi/model/task.dart';
import 'package:todo_c10_maadi/shared/providers/auth_provider.dart';
import 'package:todo_c10_maadi/shared/remote/firebase/firestore_helper.dart';
import 'package:todo_c10_maadi/style/app_colors.dart';

class ListTab extends StatefulWidget {
  const ListTab({Key? key}) : super(key: key);

  @override
  State<ListTab> createState() => _ListTabState();
}

class _ListTabState extends State<ListTab> {
  DateTime selectedDate = DateTime.now();
  @override
  Widget build(BuildContext context) {
    Authprovider provider = Provider.of<Authprovider>(context);
    return Column(
      children: [
        AppBar(

        ),
        EasyInfiniteDateTimeLine(
          firstDate: DateTime.now(),
          focusDate: selectedDate,
          lastDate: DateTime.now().add(Duration(days: 365)),
          timeLineProps: EasyTimeLineProps(
            separatorPadding: 20
          ),
          dayProps: EasyDayProps(
            activeDayStyle: DayStyle(
                decoration: BoxDecoration(
                  color: AppColors.primaryLightColor,
                )
            ),
            inactiveDayStyle: DayStyle(
                decoration: BoxDecoration(
                  color: Colors.white,
                )
            )
          ),
          showTimelineHeader: false,
          onDateChange: (newSelectedDate) {
            setState(() {
              selectedDate = DateTime(
                  newSelectedDate.year,
                  newSelectedDate.month,
                  newSelectedDate.day
              );
              print(selectedDate.toString());
            });
          },
        ),
        SizedBox(height: 10,),
        Expanded(child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: StreamBuilder(
              stream: FirestoreHelper.ListenToTasks(provider.firebaseUserAuth!.uid,selectedDate.millisecondsSinceEpoch),
              builder: (context , snapshot){
                if(snapshot.connectionState == ConnectionState.waiting){
                  // loading
                  return Center(child: CircularProgressIndicator(),);
                }
                if(snapshot.hasError){
                  // error
                  return Column(
                    children: [
                      Text("Something went wrong ${snapshot.error}"),
                      ElevatedButton(onPressed: (){}, child: Text("Try again"))
                    ],
                  );
                }
                // success data returned
                List<Task> tasks = snapshot.data??[];
                return ListView.separated(
                  separatorBuilder: (context,index)=>SizedBox(height: 20,),
                  itemBuilder: (context,index)=>TaskWidget(
                    task: tasks[index],
                  ),itemCount: tasks.length,);
              }
          ),
        ))
      ],
    );
  }
}
