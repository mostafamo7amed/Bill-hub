import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../app/resources/color_manager.dart';
import '../../app/resources/styles_manager.dart';

String uid = '';

Widget defaultFormField({
  required TextEditingController controller,
  required String label,
  prefix,
  required validate,
  required TextInputType type,
  required context,
  suffix,
  pressedShow,
  onTap,
  onSubmit,
  onChange,
  bool isPassword = false,
}) =>
    SizedBox(
      height: 70,
      child: TextFormField(
        controller: controller,
        obscureText: isPassword,
        onTap: onTap,
        onFieldSubmitted: onSubmit,
        onChanged: onChange,
        style: getRegularStyle(color: ColorManager.black, fontSize: 16),
        decoration: InputDecoration(
          label: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5.0),
            child: Text(label,
                style: getRegularStyle(color: ColorManager.black, fontSize: 16)),
          ),
          prefixIcon: prefix,
          suffixIcon: suffix != null
              ? IconButton(
                  icon: suffix,
                  onPressed: pressedShow,
                  color: ColorManager.primary,
                )
              : null,
          border: const OutlineInputBorder(

          ),
          labelStyle: getRegularStyle(color: ColorManager.black, fontSize: 16),
          prefixIconColor: ColorManager.primary,
        ),
        validator: validate,
        keyboardType: type,
        textAlignVertical: TextAlignVertical.center,
      ),
    );

PreferredSizeWidget defaultAppBar({
  required BuildContext context,
  String? title,
  List<Widget>? actions,
}) =>
    AppBar(
      titleSpacing: 0,
      leading: IconButton(
        padding: EdgeInsets.zero,
        onPressed: () {
          Navigator.pop(context);
        },
        icon: const Icon(Icons.arrow_back_outlined),
      ),
      title: Text(title!),
      actions: actions,
    );

Widget defaultButton({
  required onPressed,
  required String text,
  required double width,
  bool toUpperCase = false,
}) =>
    Container(
      width: width,
      height: 45,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(7),
        color: ColorManager.primary,
      ),
      child: MaterialButton(
        onPressed: onPressed,
        child: Text(
          toUpperCase ? text.toUpperCase() : text,
          style: const TextStyle(
            fontSize: 16,
            color: Colors.white,
          ),
        ),
      ),
    );

Future navigateTo(context, widget) => Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => widget,
    ));

Future navigateAndFinish(context, widget) => Navigator.pushAndRemoveUntil(
    context,
    MaterialPageRoute(
      builder: (context) => widget,
    ),
    (route) => false);

Future<bool?> toast({
  required String message,
  required ToastStates data,
}) =>
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 5,
        backgroundColor: changeToastColor(data),
        textColor: Colors.white,
        fontSize: 16.0);

enum ToastStates {
  success,
  error,
  warning,
}

Color changeToastColor(ToastStates data) {
  Color color;
  switch (data) {
    case ToastStates.success:
      color = Colors.green;
      break;
    case ToastStates.error:
      color = Colors.red;
      break;
    case ToastStates.warning:
      color = Colors.amber;
      break;
  }
  return color;
}
