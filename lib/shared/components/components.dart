import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:url_launcher/url_launcher.dart';

Widget defaultButton({
  double width = double.infinity,
  Color color = Colors.blue,
  double height = 40.0,
  double radius = 0.0,
  bool isUpperCase = true,
  FontWeight fontWeight = FontWeight.normal,
  required VoidCallback function,
  required String text,
}) =>
    Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(
          radius,
        ),
        color: color,
      ),
      child: MaterialButton(
        onPressed: function,
        child: Text(
          isUpperCase ? text.toUpperCase() : text,
          style: TextStyle(
            color: Colors.white,
            fontWeight: fontWeight,
            fontSize: 25.0,
          ),
        ),
      ),
    );

Widget defaultTextFormField({
  bool isPassword = false,
  ValueChanged<String>? onChange,
  VoidCallback? onTap,
  ValueChanged<String>? onFieldSubmitted,
  required String? Function(String?) validate,
  required TextEditingController controller,
  required TextInputType type,
  required String labelText,
  required IconData prefix,
  IconData? suffix,
  VoidCallback? suffixPressed,
  double radius = 0.0,
  int? maxLines = 2,
  int? minLines = 1,
}) =>
    TextFormField(
      controller: controller,
      obscureText: isPassword,
      keyboardType: type,
      onFieldSubmitted: onFieldSubmitted,
      onTap: onTap,
      validator: validate,
      maxLines: maxLines,
      minLines: minLines,
      onChanged: onChange,
      decoration: InputDecoration(
        labelText: labelText,
        prefixIcon: Icon(
          prefix,
        ),
        suffix: (suffix != null)
            ? IconButton(
                icon: Icon(
                  suffix,
                ),
                onPressed: suffixPressed,
              )
            : null,
        border: const OutlineInputBorder(),
      ),
    );


Widget separator()
  =>
    Container(
      width: double.infinity,
      height: 1.0,
      color: Colors.grey,
    );

void navigateToPage(context, widget)
  =>
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => widget,
      ),
    );

void navigateToURL({
  required String url,
}) async {
  if (await canLaunch(url)) {
    await launch(url, forceSafariVC: false, forceWebView: false);
  } else {
    throw 'Could not launch $url';
  }
}

void navigateAndFinish(context,widget)
  =>
    Navigator.pushAndRemoveUntil(
    context,
    MaterialPageRoute(
        builder: (context) =>widget
    ), (route) => false,
);

void showToast({
  required String text,
  required ToastStates state
})
  =>
    Fluttertoast.showToast(
        msg: text,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 4,
        backgroundColor: chooseToastColor(state),
        textColor: Colors.white,
        fontSize: 16.0
    );

enum ToastStates{
  SUCCESS,
  ERROR,
  WARNING
}

Color chooseToastColor(ToastStates state){
  Color color;
  switch(state)
  {
    case ToastStates.SUCCESS:
      color = Colors.green;
      break;
    case ToastStates.WARNING:
      color = Colors.yellow;
      break;
    case ToastStates.ERROR:
      color = Colors.red;
      break;
  }
  return color;
}
