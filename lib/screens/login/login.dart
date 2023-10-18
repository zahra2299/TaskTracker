import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/screens/sign_up/sign_up.dart';
import 'package:todo/shared/network/firebase/firebase_manager.dart';

import '../../layout/home_layout.dart';
import '../../providers/my_provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class LoginScreen extends StatelessWidget {
  static const String routeName = "Login";

  var _formKey = GlobalKey<FormState>();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<MyProvider>(context);
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: Text("Todo App"),
          bottom: TabBar(tabs: [
            Tab(
              text: AppLocalizations.of(context)!.login,
            ),
            Tab(
              text: AppLocalizations.of(context)!.signup,
            ),
          ]),
        ),
        body: TabBarView(children: [
          Padding(
            padding: const EdgeInsets.all(18.0),
            child: Form(
              key: _formKey, //to make validation
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  TextFormField(
                    controller: emailController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                        labelText: AppLocalizations.of(context)!.email),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return AppLocalizations.of(context)!.emptyEmail;
                      }
                      final bool emailValid = RegExp(
                              r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                          .hasMatch(value);
                      if (!emailValid) {
                        return AppLocalizations.of(context)!.invalidEmail;
                      }
                      return null;
                    },
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    controller: passwordController,
                    obscureText: true,
                    decoration: InputDecoration(
                        labelText: AppLocalizations.of(context)!.password),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return AppLocalizations.of(context)!.emptyPassword;
                      }
                      return null;
                    },
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  ElevatedButton(
                      onPressed: () {
                        //should make this condition so validator works
                        if (_formKey.currentState!.validate()) {
                          FirebaseManager.login(
                              emailController.text, passwordController.text,
                              () {
                            provider
                                .initUser(); //before going to home initialize the user
                            Navigator.pushNamedAndRemoveUntil(context,
                                HomeLayout.routeName, (route) => false);
                          }, (error) {
                            showDialog(
                              context: context,
                              barrierDismissible: false,
                              builder: (context) => AlertDialog(
                                title:
                                    Text(AppLocalizations.of(context)!.error),
                                content: Text(error),
                                actions: [
                                  ElevatedButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      child: Text(
                                          AppLocalizations.of(context)!.ok))
                                ],
                              ),
                            );
                          });
                        }
                      },
                      child: Text(AppLocalizations.of(context)!.login))
                ],
              ),
            ),
          ),
          SignUp(),
        ]),
      ),
    );
  }
}
