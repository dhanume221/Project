// import 'dart:nativewrappers/_internal/vm/lib/core_patch.dart';

import 'package:flutter/material.dart';
import 'package:taskmanagement/firstpage.dart';
import 'package:taskmanagement/task_provider.dart';
import 'package:taskmanagement/login.dart';



class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
   
  @override
  void initState(){
     super.initState();
     moveToNext();
     
  }

 void moveToNext() async{
    await Future.delayed(Duration(seconds: 2));
    final bool isloggedin = await gettingBoolData();
    if(isloggedin)
    {
   Navigator.push(context, MaterialPageRoute(builder: (context) => Firstpage(),));
 
    }
    else{
   Navigator.push(context, MaterialPageRoute(builder: (context) => LoginPage(),));
 
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
       
            children: [
              Image.asset(
                "asset/tasklogo.jpg", 
                width: 190,
                height: 110,
              ),

             const Text("TASK MANAGEMENT SYSTEM",style: TextStyle(fontWeight: FontWeight.w700,fontSize: 20,color: Color.fromARGB(255, 217, 75, 3),),)
            ],
          ),
          
        ]
     ),
     
    );
  }

  

}


