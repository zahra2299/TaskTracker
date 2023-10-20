import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';
import 'package:todo/models/task_model.dart';
import 'package:todo/providers/settings_provider.dart';
import 'package:todo/screens/tasks/edit_task_screen.dart';
import 'package:todo/shared/network/firebase/firebase_manager.dart';
import 'package:todo/shared/styles/colors.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class TaskItem extends StatelessWidget {
  TaskModel task;

  TaskItem(this.task, {super.key});

  @override
  Widget build(BuildContext context) {
    var pro = Provider.of<SettingsProvider>(context);
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      elevation: 12,
      shape: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: Colors.transparent),
      ),
      child: Slidable(
        startActionPane: ActionPane(motion: DrawerMotion(), children: [
          SlidableAction(
            onPressed: (BuildContext context) {
              FirebaseManager.deleteTask(task.id);
            },
            backgroundColor: Colors.red,
            label: AppLocalizations.of(context)!.delete,
            icon: Icons.delete,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(8), bottomLeft: Radius.circular(8)),
          ),
          SlidableAction(
            onPressed: (BuildContext context) {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => EditTaskScreen(task: task),
                  ));
            },
            icon: Icons.edit,
            backgroundColor: Colors.blue,
            label: AppLocalizations.of(context)!.edit,
          )
        ]),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Container(
                height: 80,
                width: 4,
                decoration: BoxDecoration(
                  color: task.isDone ? green : primary,
                  borderRadius: BorderRadius.circular(24),
                  border: Border.all(color: Colors.blue),
                ),
              ),
              SizedBox(width: 20),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(task.title,
                      style: TextStyle(
                          color: task.isDone ? green : Colors.blue,
                          fontSize: 18,
                          fontWeight: FontWeight.bold)),
                  Text(task.description,
                      style: TextStyle(
                          color: pro.theme == ThemeMode.light
                              ? Colors.black54
                              : white,
                          fontSize: 14,
                          fontWeight: FontWeight.w400)),
                ],
              ),
              Spacer(),
              InkWell(
                onTap: () {
                  task.isDone = true;
                  FirebaseManager.updateTask(task);
                },
                child: task.isDone
                    ? Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Text(
                          AppLocalizations.of(context)!.done,
                          style: TextStyle(
                            color: Colors.green,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      )
                    : Container(
                        margin: EdgeInsets.only(right: 12),
                        padding:
                            EdgeInsets.symmetric(horizontal: 16, vertical: 2),
                        decoration: BoxDecoration(
                            color: task.isDone ? Colors.green : primary,
                            borderRadius: BorderRadius.circular(12)),
                        child: //task.isDone
                            // //     ? Text(AppLocalizations.of(context)!.done,style: TextStyle(
                            // //   color: Colors.white,
                            // //   fontSize: 20,
                            // // ),
                            // // )
                            //     :
                            Icon(Icons.done, color: Colors.white, size: 30),
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
