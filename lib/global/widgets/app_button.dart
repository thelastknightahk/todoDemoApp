 
import 'package:flutter/material.dart';

import 'package:todo_test/global/colors/colors.dart';
class AppButtonWidget extends StatelessWidget {
  String? content;
  VoidCallback? clickFunction; 
   AppButtonWidget({
    Key? key,
    this.content,
    this.clickFunction,
  }) : super(key: key);
    

  @override
  Widget build(BuildContext context) {
    return Container(
                                margin:
                                    const EdgeInsets.symmetric(vertical: 10.0),
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  color: AppColor.primaryColor,
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                child: TextButton(
                                  onPressed:  clickFunction,
                                  child:  Text(
                                    '$content',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 18.0,
                                    ),
                                  ),
                                ),
                              );
  }
}

// Widget appAuthButton(BuildContext context, String content, Function()? clickFunction ){
//   return  InkWell(
//     onTap:  clickFunction,
//     child: Container(
//                                 margin:
//                                     const EdgeInsets.symmetric(vertical: 10.0),
//                                 width: double.infinity,
//                                 decoration: BoxDecoration(
//                                   color: AppColor.primaryColor,
//                                   borderRadius: BorderRadius.circular(10.0),
//                                 ),
//                                 child: TextButton(
//                                   onPressed: () {
                                    
//                                   },
//                                   child:  Text(
//                                     '$content',
//                                     style: TextStyle(
//                                       color: Colors.white,
//                                       fontSize: 18.0,
//                                     ),
//                                   ),
//                                 ),
//                               ),
//   );
// }