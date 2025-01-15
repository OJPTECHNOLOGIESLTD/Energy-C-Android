import 'package:energy_chleen/utils/Helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RecycleTipVideo extends StatelessWidget {
  const RecycleTipVideo({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
              children: [
                Container(
                  height: MediaQuery.of(context).size.height * 0.25,
                  color: Colors.grey.shade200,
                  child: Center(
                    child:Stack(
                      children: [
                        Image.asset('assets/vid.jpg'),
                       Positioned(
                        left: 0,
                        right: 0,
                        bottom: 0,
                        top: 0,
                        child: IconButton(
                          onPressed: () {
                            print('Play Video');
                          },
                          icon: Stack(
                            children: 
                            [
                              Icon(Icons.circle_outlined,
                              size: 80,
                              color: Customcolors.white,),
                              Positioned(
                                left: 5,
                                right: 0,
                                bottom: 0,
                                top: 0,
                                child: Icon(
                                CupertinoIcons.play_arrow_solid,
                                 size: 50,
                                 color: Customcolors.white,),
                              ),
                               ]
                               ),
                               ),
                              )
                        ])),
                ),
                Positioned(
                  left: 20,
                  top: 16,
                  child: Container(
                    width: 40,
                    padding: EdgeInsets.only(bottom: 1, left: 5),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
                    ),
                    child: Center(
                      child: IconButton(
                        icon: Icon(Icons.arrow_back_ios, color: Colors.black, size: 18),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                    ),
                  ),
                ),
              ],
            );
            
  }
}