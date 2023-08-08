import 'package:demo/services/auth_service.dart';
import 'package:demo/themes_and_constants/themes.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {

  FirebaseAuth auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColors.backgroundColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              //crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text('Delete User Credentials', style: TextStyle(color: CustomColors.primaryColor, fontSize: 18, fontWeight: FontWeight.bold),),
                ElevatedButton(onPressed: () async{
                  await AuthService().deleteUser();
                }, child: Text("Delete User"))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
