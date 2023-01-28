 
import 'package:flutter/material.dart';
import 'package:todo_test/global/colors/colors.dart';

class TextInputWidget extends StatelessWidget {
  bool? password;
  Widget? foreIcon;
  String? textContent;
  TextEditingController? textEditingController;
  TextInputWidget({
    Key? key,
    this.password,
    this.foreIcon,
    this.textContent,
    this.textEditingController
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4.0),
        child: TextField(
          controller: textEditingController,
          cursorColor: AppColor.primaryColor,
          decoration: InputDecoration(
              border: InputBorder.none,
              prefixIcon: foreIcon,
              hintText: textContent,
              hintStyle: const TextStyle(color: AppColor.primaryColor),
              suffixIcon: password!
                  ? const Icon(
                      Icons.visibility,
                      color: AppColor.primaryColor,
                    )
                  : const SizedBox()),
        ),
      ),
    );
  }
}
