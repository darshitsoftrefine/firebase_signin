import 'package:demo/auth_screen/custom_field.dart';
import 'package:demo/auth_screen/register_screen.dart';
import 'package:demo/themes_and_constants/themes.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sign_in_button/sign_in_button.dart';
import '../screens/home.dart';
import '../services/auth_service.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool isLoading = false;
  
  @override
  void initState() {
    emailController.addListener(() {
      setState(() {

      });
    });
    passwordController.addListener(() { setState(() {

    });
    });
    super.initState();
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColors.backgroundColor,
      appBar: AppBar(
        backgroundColor: CustomColors.backgroundColor,
        elevation: 0.0,
        leading: IconButton(onPressed: (){}, icon: Icon(Icons.arrow_back_ios),),
      ),
      //resizeToAvoidBottomInset: false,
      body: Padding(
        padding: const EdgeInsets.only(top: 41.0, left: 24, right: 24),
        child: SingleChildScrollView(
          //physics: NeverScrollableScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Login", style: TextStyle(fontSize: 32, fontWeight: FontWeight.w700, color: CustomColors.primaryColor),),
              const SizedBox(height: 10,),
              //Text("Please enter your details to access your account", style: TextStyle(color: Colors.grey.shade500, fontSize: 12),),
              const SizedBox(height: 20,),
              Text("Email", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: CustomColors.primaryColor),),
              const SizedBox(height: 15,),
              CustomField(label: 'Email Id', control: emailController, obs: false, hint: 'Enter your E-mail',),
              const SizedBox(height: 25,),
              Text("Password", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: CustomColors.primaryColor),),
              const SizedBox(height: 15,),
              CustomField(label: 'Password', control: passwordController, obs: true, hint: '.   .   .   .   .   .   .',),
              const SizedBox(height: 70,),
              isLoading ? const Center(child: CircularProgressIndicator()):
              Container(
                alignment: Alignment.center,
                //width: MediaQuery.of(context).size.width,
                  child: ElevatedButton(onPressed: emailController.text.isEmpty && passwordController.text.isEmpty ? null : () async{
                setState(() {
                  isLoading = true;
                });
                if(emailController.text == "" || passwordController.text == ""){
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("All Fields are required"), backgroundColor: Colors.red,));
                } else {
                 User? result = await AuthService().login(emailController.text, passwordController.text, context);
                 if(result != null){
                   Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=> Home(result)), (route) => false);
                 }
                      }
                setState(() {
                  isLoading = false;
                });
              },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: CustomColors.circleColor,
                      disabledBackgroundColor: CustomColors.circColor,
                      fixedSize: const Size(367, 48)
                    ),
                      child: const Text("Login", style: TextStyle(color: Colors.white),),
                  )),
              const SizedBox(height: 31,),
              Row(
                  children: const <Widget>[
                    Expanded(
                        child: Divider(color: Colors.grey,)
                    ),

                    Text("  or  ", style: TextStyle(color: Colors.grey),),

                    Expanded(
                        child: Divider(color: Colors.grey,)
                    ),
                  ]
              ),
              const SizedBox(height: 30,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  isLoading ? const CircularProgressIndicator():
                  ElevatedButton(
                    onPressed: () async{
                      setState(() {
                        isLoading = true;
                      });
                      await AuthService().signInWithGoogle();
                      setState(() {
                        isLoading = false;
                      });
                    },
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.only(left: 15, right: 15, top: 5, bottom: 5),
                      primary: CustomColors.backgroundColor,
                      onPrimary: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                        side: BorderSide(color: CustomColors.circColor)
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset('assets/images/googl.png', width: 30, height: 30,),
                        SizedBox(width: 10),
                        Text('Login with Google'),
                      ],
                    ),
                  )
                ],
              ),
              SizedBox(height: 130,),
              Container(
                alignment: Alignment.center,
                child: TextButton(onPressed: (){
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const RegisterScreen()),
                  );
                }, child: RichText(
                  text: TextSpan(
                    text: "Don't have an account?",
                    style: TextStyle(color: Colors.grey, fontSize: 12),
                    children: [
                      TextSpan(
                        text: 'Register',
                        style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700, fontSize: 12),
                      ),

                    ],
                  ),
                )),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
