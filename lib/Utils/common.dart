import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';

const Color kPrimaryColor = Color(0xff6015FF);

const Color kWhiteColor = Color(0xffffffff);
const Color kBlackColor = Color(0xff000000);
const Color kTextColor=Color(0xffB0ADAD);
var fontMontserrat = GoogleFonts.montserrat;

customToast(String msg) => Fluttertoast.showToast(
    msg: msg,
    toastLength: Toast.LENGTH_SHORT,
    gravity: ToastGravity.SNACKBAR,
    timeInSecForIosWeb: 3,
    backgroundColor: kWhiteColor,
    textColor: kBlackColor,
    fontSize: 16.0);

customProgressIndicator() => const Center(
  child: CircularProgressIndicator.adaptive(
    strokeWidth: 4,
    valueColor: AlwaysStoppedAnimation<Color>(kPrimaryColor),
  ),
);

String printDuration(Duration duration) {
  String twoDigits(int n) => n.toString().padLeft(2, "0");
  String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
  String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
  return "$twoDigitMinutes:$twoDigitSeconds";
}
Widget bodyText(
    {required String text,
      int maxLines = 1,
      double fontSize = 16,
      FontWeight fontWeight = FontWeight.bold,
      TextAlign textAlign = TextAlign.start,
      Color fontColor = Colors.white}) =>
    Text(
      text,
      textAlign: textAlign,
      maxLines: maxLines,
      style: GoogleFonts.montserrat(fontSize: fontSize, fontWeight: fontWeight, color: fontColor),
    );