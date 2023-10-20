import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:todo/shared/styles/colors.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../models/task_model.dart';
import '../../providers/settings_provider.dart';
import '../../shared/network/firebase/firebase_manager.dart';

class EditTaskScreen extends StatefulWidget {
  static const routeName = "Edit screen";
  final TaskModel task;

  const EditTaskScreen({
    Key? key,
    required this.task,
  });

  @override
  State<EditTaskScreen> createState() => _EditTaskScreenState();
}

class _EditTaskScreenState extends State<EditTaskScreen> {
  var titleController = TextEditingController();
  var descriptionController = TextEditingController();
  var selectedDate;

  // TaskModel? args;

  @override
  void initState() {
    super.initState();
    selectedDate =
        DateTime.fromMillisecondsSinceEpoch(widget.task.date) ?? DateTime.now();
    titleController.text = widget.task.title;
    descriptionController.text = widget.task.description;
  }

  @override
  Widget build(BuildContext context) {
    // if (args == null) {
    //   args = ModalRoute.of(context)!.settings.arguments as TaskModel;
    //   selectedDate = DateTime.fromMillisecondsSinceEpoch(args!.date )?? DateTime.now();
    //   titleController.text = args!.title;
    //   descriptionController.text = args!.description;
    // }
    var pro = Provider.of<SettingsProvider>(context);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text("To Do List"),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Card(
              shape: OutlineInputBorder(
                borderRadius: BorderRadius.circular(18),
                borderSide: BorderSide(color: primary),
              ),
              child: Padding(
                padding: const EdgeInsets.all(30.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(AppLocalizations.of(context)!.editTask,
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
                        label:
                            Text(AppLocalizations.of(context)!.taskDescription),
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
                          TaskModel taskModel = TaskModel(
                              userId: widget.task.userId,
                              title: titleController.text,
                              description: descriptionController.text,
                              date: DateUtils.dateOnly(selectedDate)
                                  .millisecondsSinceEpoch,
                              id: widget.task.id,
                              isDone: widget.task.isDone);
                          FirebaseManager.updateTask(taskModel);
                          showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                content: Text("Task edited successfully"),
                                actions: [
                                  ElevatedButton(
                                      onPressed: () {
                                        //to close the alert
                                        Navigator.pop(context);
                                        //to close the bottom sheet
                                        Navigator.pop(context);
                                      },
                                      child: Text(
                                          AppLocalizations.of(context)!.done))
                                ],
                              );
                            },
                          );
                        },
                        child: Text(AppLocalizations.of(context)!.saveChanges)),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  selectDate() async {
    DateTime? chosenDate = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(Duration(days: 365)),
      builder: (context, child) {
        return Theme(
            data: ThemeData.light().copyWith(
              colorScheme: ColorScheme.light(
                primary: Colors.blue,
                onPrimary: Colors.white,
                onSecondary: Colors.grey,
                onSurface: Colors.black87,
              ),
            ),
            child: child!);
      },
    );
    if (chosenDate == null) {
      return;
    }
    selectedDate = DateUtils.dateOnly(chosenDate);
    setState(() {});
  }
}
