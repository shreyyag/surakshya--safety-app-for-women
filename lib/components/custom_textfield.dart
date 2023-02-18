import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String? hintText;
  final TextEditingController? controller;
  final String? Function(String?)? validate;
  final int? maxLines;
  final bool isPassword;
  final bool? check;
  final bool enable;
  final TextInputType? keyboardtype;
  final TextInputAction? textInputAction;
  final FocusNode? focusNode;
  final Widget? prefix;
  final Widget? suffix;

  CustomTextField(
      {this.controller,
      this.validate,
      this.maxLines,
      this.isPassword = false,
      this.enable = true,
      this.keyboardtype,
      this.textInputAction,
      this.focusNode,
      this.prefix,
      this.suffix,
      this.hintText,
      this.check});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      enabled: enable == true ? true : enable,
      maxLines: maxLines == null ? 1 : maxLines,
      focusNode: focusNode,
      textInputAction: textInputAction,
      keyboardType: keyboardtype == null ? TextInputType.name : keyboardtype,
      controller: controller,
      validator: validate,
      obscureText: isPassword == false ? false : isPassword,
      decoration: InputDecoration(
          prefixIcon: prefix,
          suffixIcon: suffix,
          labelText: hintText ?? "hint text..",
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(
              style: BorderStyle.solid,
              color: Theme.of(context).primaryColor,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(
              style: BorderStyle.solid,
              color: Colors.grey,
            ),
          ),
          focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(
                style: BorderStyle.solid,
                color: Theme.of(context).primaryColor,
              )),
          errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(
                color: Colors.red,
                style: BorderStyle.solid,
              ))),
    );
  }
}
