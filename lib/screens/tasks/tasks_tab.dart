import 'package:calendar_timeline/calendar_timeline.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:todo/screens/tasks/task_item.dart';
import 'package:todo/shared/network/firebase/firebase_manager.dart';
import 'package:todo/shared/styles/colors.dart';

import '../../models/task_model.dart';

class TasksTab extends StatefulWidget {
  @override
  State<TasksTab> createState() => _TasksTabState();
}

class _TasksTabState extends State<TasksTab> {
  var selectedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CalendarTimeline(
          initialDate: selectedDate,
          firstDate: DateTime.now().subtract(Duration(days: 365)),
          lastDate: DateTime.now().add(Duration(days: 365)),
          onDateSelected: (date) {
            selectedDate = date;
            setState(() {});
          },
          leftMargin: 20,
          monthColor: primary,
          dayColor: Colors.grey,
          activeDayColor: Colors.white,
          activeBackgroundDayColor: primary,
          dotsColor: Colors.white,
          selectableDayPredicate: (date) => true,
          locale: 'en_ISO',
        ),
        Expanded(
            // to get anything from the future we use future builder instead of ListView
            // streamBuilder make online connection between database and app[real time changes]
            child: StreamBuilder<QuerySnapshot<TaskModel>>(
          //the thing that is coming from future
          //when the blue thing get on a certain date get the tasks with that date
          stream: FirebaseManager.getTasks(selectedDate),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            }
            if (snapshot.hasError) {
              return Center(child: Text("Something went wrong"));
            }
            //convert each doc we got from database to a list of TaskModel using map()
            //convert a list to another type of list we use map()
            // ??[] means return empty list if we got no data
            //it's like fromJason()
            var tasks =
                snapshot.data?.docs.map((doc) => doc.data()).toList() ?? [];

            return ListView.builder(
              itemBuilder: (context, index) {
                return TaskItem(tasks[index]);
              },
              itemCount: tasks.length,
            );
          },
        ))
      ],
    );
  }
}
