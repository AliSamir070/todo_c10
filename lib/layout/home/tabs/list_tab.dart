import 'package:easy_date_timeline/easy_date_timeline.dart';
import 'package:flutter/material.dart';
import 'package:todo_c10_maadi/style/app_colors.dart';

class ListTab extends StatelessWidget {
  const ListTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        EasyInfiniteDateTimeLine(
          firstDate: DateTime.now(),
          focusDate: DateTime.now(),
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
          onDateChange: (selectedDate) {

          },
        ),
      ],
    );
  }
}
