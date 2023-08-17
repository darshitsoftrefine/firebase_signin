import 'package:demo/themes_and_constants/image_constants.dart';
import 'package:demo/themes_and_constants/themes.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../auth_screen/login_screen.dart';
import '../services/auth_service.dart';
import '../themes_and_constants/string_constants.dart';

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {

  FirebaseAuth auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    String? text = auth.currentUser!.email;
    return Scaffold(
      backgroundColor: CustomColors.backgroundColor,
      appBar: AppBar(
        backgroundColor: CustomColors.backgroundColor,
        elevation: 0,
        title: const Text(ConstantStrings.settingsText),
        centerTitle: true,
      ),
      body:SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(top: 40, left: 34, right: 34, bottom: 190),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              auth.currentUser!.photoURL == null? const CircleAvatar(backgroundImage: AssetImage(ConstantImages.placeHoldImage), radius: 50,): CircleAvatar(backgroundImage: NetworkImage('${auth.currentUser!.photoURL}'), radius: 50,),
              const SizedBox(height: 30,),

              //Text(auth.currentUser!.email!.substring(0, text!.lastIndexOf("@")), style: TextStyle(color: Colors.white),),
              auth.currentUser!.displayName == null? Text(auth.currentUser!.email!.substring(0, text?.lastIndexOf("@")),style: const TextStyle(color: Colors.white, fontSize: 20),) :Text("${auth.currentUser!.displayName}",style: const TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.w500),),
              const SizedBox(height: 20,),
              Text("${auth.currentUser!.email}", style: const TextStyle(color: Colors.white, fontSize: 14),),
              const SizedBox(height: 20,),
              ElevatedButton.icon(
                onPressed: () async{
                  await AuthService().deleteUser(context);
                  },
                icon: const Icon(
                  Icons.delete,
                  size: 24.0,
                ),
                label: const Text('Delete your account', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),),
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.zero,
                    backgroundColor: CustomColors.backgroundColor
                ),
              ),
              const SizedBox(height: 8,),
              ElevatedButton.icon(onPressed: () async{
                await AuthService().signOut();
                // ignore: use_build_context_synchronously
                Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => const LoginScreen()),(route) => false);
              }, icon: const Icon(Icons.logout, color: Colors.red, size: 24,), label: const Text("Log out", style: TextStyle(color: Colors.red, fontSize: 16, fontWeight: FontWeight.w400),),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.only(left: 3),
                    backgroundColor: Colors.black
                ),)
            ],
          ),
        ),
      ),
    );
  }
}
