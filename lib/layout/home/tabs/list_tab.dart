import 'package:easy_date_timeline/easy_date_timeline.dart';
import 'package:flutter/material.dart';
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
    return Column(
      children: [
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
              selectedDate = newSelectedDate;
            });
          },
        ),
      ],
    );
  }
}
