import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';

class AppToasts {
  static void showToast({
    required BuildContext context,
    required String title,
  }) {
    FToast().init(context);
    FToast().showToast(
      positionedToastBuilder: (context, child) {
        return Positioned(top: 44.0, left: 24.0, right: 24.0, child: child);
      },
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
            color: Colors.green,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: Colors.greenAccent,
            )),
        child: Padding(
          padding: const EdgeInsets.all(18),
          child: Row(
            children: [
              const SizedBox(width: 10),
              Center(
                child: Text(
                  title,
                  style: GoogleFonts.roboto(color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  static void showErrorToast({
    required BuildContext context,
    required String title,
  }) {
    FToast().init(context);
    FToast().showToast(
      positionedToastBuilder: (context, child) {
        return Positioned(top: 44.0, left: 24.0, right: 24.0, child: child);
      },
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
            color: Colors.red,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: Colors.redAccent,
            )),
        child: Padding(
          padding: const EdgeInsets.all(18),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: Text(
                  title,
                  style: GoogleFonts.roboto(color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
