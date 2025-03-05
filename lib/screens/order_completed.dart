import 'package:energy_chleen/utils/Helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OrderCompleted extends StatelessWidget {
  const OrderCompleted({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
          RecyclingScheduleProgress(
                  isReviewing: true,
                  isCompleted: true,
                  isTakingPhoto: true,
                ),
                SizedBox(height: 70,),
                CircleAvatar(
                  radius: 50,
                  backgroundColor: Customcolors.teal,
                  child: Icon(Icons.done,
                  color: Colors.white,
                  size: 70,),),
        
                  SizedBox(height: 24,),
                  Text('Pickup Request Submitted!',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
                  SizedBox(height: 24,),
                  Text(
                    textAlign: TextAlign.center,
                    'Thank you for scheduling your waste pickup with Energy Chleen! Your request has been successfully submitted.\n\n\nOur team is currently reviewing your request to ensure all details are accurate. You\'ll receive a notification once your pickup is approved',
                    style: TextStyle(fontSize: 16,),),

                    SizedBox(height: 50,),
                    GestureDetector(
                      onTap: (){
                       Get.offAllNamed('/homepage');  // Navigate to homepage if logged in
                      },
                      child: Container(
                        width: 150,
                        padding: EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Customcolors.teal,
                          borderRadius: BorderRadius.circular(16)
                        ),
                        child: Text(
                          textAlign: TextAlign.center,
                          'Close',
                        style: TextStyle(color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w700),),
                      ),
                    )
        ],),
      ),
    );
  }
}