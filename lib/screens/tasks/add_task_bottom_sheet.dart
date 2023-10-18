import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:todo/models/task_model.dart';
import 'package:todo/shared/network/firebase/firebase_manager.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:todo/shared/styles/colors.dart';

import '../../providers/settings_provider.dart';

class AddTaskBottomSheet extends StatefulWidget {
  @override
  State<AddTaskBottomSheet> createState() => _AddTaskBottomSheetState();
}

class _AddTaskBottomSheetState extends State<AddTaskBottomSheet> {
  var titleController = TextEditingController();

  var descriptionController = TextEditingController();
  var selectedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    var pro = Provider.of<SettingsProvider>(context);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(AppLocalizations.of(context)!.addNewTask,
              textAlign: TextAlign.center,
              style: GoogleFonts.poppins(
                color: pro.theme == ThemeMode.light ? black : white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              )),
          SizedBox(
            height: 24,
          ),
          TextFormField(
            controller: titleController,
            decoration: InputDecoration(
              label: Text(AppLocalizations.of(context)!.taskTitle),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: Colors.blue),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: Colors.blue),
              ),
            ),
          ),
          SizedBox(
            height: 18,
          ),
          TextFormField(
            controller: descriptionController,
            decoration: InputDecoration(
              label: Text(AppLocalizations.of(context)!.taskDescription),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: Colors.blue),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: Colors.blue),
              ),
            ),
          ),
          SizedBox(
            height: 18,
          ),
          Text(AppLocalizations.of(context)!.selectDate,
              style: GoogleFonts.poppins(
                fontWeight: FontWeight.bold,
                fontSize: 20,
                color: pro.theme == ThemeMode.light ? black : white,
              )),
          SizedBox(
            height: 9,
          ),
          InkWell(
            onTap: () {
              selectDate();
            },
            child: Text(selectedDate.toString().substring(0, 10),
                textAlign: TextAlign.center,
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.w500,
                  fontSize: 14,
                  color: Colors.blue,
                )),
          ),
          SizedBox(
            height: 18,
          ),
          ElevatedButton(
              onPressed: () {
                TaskModel task = TaskModel(
                    userId: FirebaseAuth.instance.currentUser!.uid,
                    title: titleController.text,
                    description: descriptionController.text,
                    //to get the date only without the time
                    date: DateUtils.dateOnly(selectedDate)
                        .microsecondsSinceEpoch);
                FirebaseManager.addTask(task);
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: Text(AppLocalizations.of(context)!.success),
                      content: Text(AppLocalizations.of(context)!.taskSuccess),
                      actions: [
                        ElevatedButton(
                            onPressed: () {
                              //to close the alert
                              Navigator.pop(context);
                              //to close the bottom sheet
                              Navigator.pop(context);
                            },
                            child: Text(AppLocalizations.of(context)!.done))
                      ],
                    );
                  },
                );
              },
              child: Text(AppLocalizations.of(context)!.addTask))
        ],
      ),
    );
  }

  selectDate() async {
    DateTime? chosenDate = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime.now(),
        lastDate: DateTime.now().add(Duration(days: 365)));
    if (chosenDate == null) {
      return;
    }
    selectedDate = chosenDate;
    setState(() {});
  }
}
