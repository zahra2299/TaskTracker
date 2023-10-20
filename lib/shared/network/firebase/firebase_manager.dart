import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:todo/models/task_model.dart';

import '../../../models/user_model.dart';

class FirebaseManager {
  //we make this function to add tasks to firebase but .add() take it as Map but we deal with Models
  static CollectionReference<TaskModel> getTasksCollection() {
    return FirebaseFirestore.instance
        .collection("Tasks") //the collection name in firebase
        .withConverter<TaskModel>(
      //snapshot is the data coming from database
      fromFirestore: (snapshot, _) {
        return TaskModel.fromJson(snapshot.data()!);
      },
      toFirestore: (task, _) {
        return task.toJson();
      },
    );
  }

  static Future<void> addTask(TaskModel task) {
    var collection = getTasksCollection();
    var docRef =
        collection.doc(); //create a document, empty parameter to autoId
    task.id = docRef.id; //set autoId to task id
    return docRef.set(task);
    //we make a return so we can make .then() in the bottomsheet
  }

  // get all tasks from database to the task tab
  //filter tasks according to dates
  //stream means any thing happens in database should happen in app
  static Stream<QuerySnapshot<TaskModel>> getTasks(DateTime date) {
    return getTasksCollection()
        .where("userId", isEqualTo: FirebaseAuth.instance.currentUser!.uid)
        .where("date",
            isEqualTo: DateUtils.dateOnly(date).millisecondsSinceEpoch)
        .snapshots();
  }

  static Future<void> deleteTask(String taskId) {
    return getTasksCollection().doc(taskId).delete();
  }

  static void updateTask(TaskModel model) {
    getTasksCollection().doc(model.id).update(model.toJson());
  }

  static Future<void> createAccount(String email, String password, String name,
      int age, Function onSuccess, Function onError) async {
    try {
      final credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      UserModel userModel = UserModel(
          id: credential.user!.uid, email: email, name: name, age: age);
      credential.user?.sendEmailVerification();
      addUserToFirestore(userModel);
      onSuccess();
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        onError(e.message);
      } else if (e.code == 'email-already-in-use') {
        onError(e.message);
      }
    } catch (e) {
      print(e);
    }
  }

  static Future<void> login(String email, String password, Function onSuccess,
      Function onError) async {
    try {
      final credential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      onSuccess();
    } on FirebaseAuthException catch (e) {
      if (e.code == "INVALID_LOGIN_CREDENTIALS") {
        onError("Wrong Mail or Password");
      }
      onError(e.message);
    }
  }

  static CollectionReference<UserModel> getUsersCollection() {
    return FirebaseFirestore.instance
        .collection("Users") //the collection name in firebase
        .withConverter<UserModel>(
      //snapshot is the data coming from database
      fromFirestore: (snapshot, _) {
        return UserModel.fromJson(snapshot.data()!);
      },
      toFirestore: (user, _) {
        return user.toJson();
      },
    );
  }

  static Future<void> addUserToFirestore(UserModel user) {
    var collection = getUsersCollection();
    var docRef = collection.doc(user.id);
    return docRef.set(user);
  }

  static Future<UserModel?> readUser(String id) async {
    DocumentSnapshot<UserModel> userDoc =
        await getUsersCollection().doc(id).get();
    return userDoc.data();
  }
}
