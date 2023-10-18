import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:todo/shared/network/firebase/firebase_manager.dart';
import '../models/user_model.dart';

//using it to keep the user login(auto login )
class MyProvider extends ChangeNotifier {
  UserModel? userModel; //user we want to store
  User? firebaseUser; //user already in database

  MyProvider() {
    //to check if there is user in database
    firebaseUser = FirebaseAuth.instance.currentUser;
    if (firebaseUser != null) {
      initUser();
    }
  }

  initUser() async {
    //double sure that the user is logged in
    firebaseUser = FirebaseAuth.instance.currentUser;
    //get user info and save it in the model
    userModel = await FirebaseManager.readUser(firebaseUser!.uid);
    notifyListeners();
  }
}
