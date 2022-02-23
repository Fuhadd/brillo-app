import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

var genderOptions = ['Male', 'Female'];

var interestOptions = [
  'Footall',
  'Basketall',
  'Soccer',
  'Netflix',
];

var options = const [
  FormBuilderFieldOption(value: 'Football', child: Text('Football')),
  FormBuilderFieldOption(value: 'Basketball', child: Text('Basketball')),
  FormBuilderFieldOption(value: 'Tennis', child: Text('Tennis')),
  FormBuilderFieldOption(value: 'Ice Hockey', child: Text('Ice Hockey')),
  FormBuilderFieldOption(value: 'Wrestling', child: Text('Wrestling')),
  FormBuilderFieldOption(value: 'Gaming', child: Text('Gaming')),
  FormBuilderFieldOption(value: 'Motorsports', child: Text('Motorsports')),
  FormBuilderFieldOption(value: 'Bandy', child: Text('Bandy')),
  FormBuilderFieldOption(value: 'Rugby', child: Text('Rugby')),
  FormBuilderFieldOption(value: 'Skiing', child: Text('Skiing')),
  FormBuilderFieldOption(value: 'Shooting', child: Text('Shooting')),
];

Widget vericalSpacer(double height) {
  return SizedBox(
    height: height,
  );
}

Widget horizontalSpacer(double width) {
  return SizedBox(
    width: width,
  );
}

Widget loader({double size = 50}) {
  return const SpinKitWave(
    color: Colors.pink,
  );
}

Future<dynamic> showdialog(BuildContext context) {
  return showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return SimpleDialog(
          elevation: 0,
          contentPadding: EdgeInsets.all(90),
          children: [loader()],
          backgroundColor: Colors.transparent,
        );
      });
}

InputDecoration customFormDecoration(
    String labelText, IconData? prefixIcon, IconData? suffixIcon,
    {String? helperText}) {
  return InputDecoration(
      helperText: helperText,
      floatingLabelStyle: const TextStyle(color: Colors.pink),
      fillColor: Colors.pink,
      focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.pink)),
      prefixIcon: Icon(
        prefixIcon,
        size: 20,
      ),
      suffixIcon: Icon(
        suffixIcon,
        size: 20,
      ),
      labelText: labelText);
}

FormBuilderTextField customFormBuilderTextField(
  String name,
  IconData prefixIcon,
  IconData? suffixIcon,
  String labelText, {
  String? initialValue,
  bool obscureText = false,
  String? helperText,
  String? Function(String?)? validator,
}) {
  return FormBuilderTextField(
    initialValue: initialValue,
    cursorColor: Colors.pink,
    name: name,
    obscureText: obscureText,
    validator: validator,
    decoration: customFormDecoration(labelText, prefixIcon, suffixIcon),
  );
}

InputDecoration customDateFormDecoration(String labelText, String helperText,
    IconData prefixIcon, IconData? suffixIcon) {
  return InputDecoration(
      helperText: helperText,
      floatingLabelStyle: const TextStyle(color: Colors.pink),
      fillColor: Colors.pink,
      focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.pink)),
      prefixIcon: Icon(
        prefixIcon,
        size: 20,
      ),
      suffixIcon: Icon(
        suffixIcon,
        size: 20,
      ),
      labelText: labelText);
}

FormBuilderDateTimePicker customDateFormBuilderField(
  String name,
  String helperText,
  IconData prefixIcon,
  IconData? suffixIcon,
  String labelText, {
  String? Function(String?)? validator,
}) {
  return FormBuilderDateTimePicker(
    inputType: InputType.date,
    cursorColor: Colors.pink,
    name: name,
    decoration:
        customDateFormDecoration(labelText, helperText, prefixIcon, suffixIcon),
  );
}

FormBuilderDropdown customFormBuilderDropdown(
  String name,
  IconData prefixIcon,
  IconData? suffixIcon,
  String labelText, {
  String? Function(String?)? validator,
  var items,
}) {
  return FormBuilderDropdown(
    name: name,
    items: items,
    decoration: customFormDecoration(labelText, prefixIcon, suffixIcon),
  );
}
