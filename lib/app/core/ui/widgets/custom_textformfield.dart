import 'package:flutter/material.dart';
import 'package:get/utils.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class CustomTextformfield extends StatelessWidget {
  final String label;
  final TextEditingController? controller;
  final bool obscureText;
  final bool cellMask;
  final FormFieldValidator<String>? validator;
  final ValueChanged<String>? onChange;
  final int? maxlines;
  final int? minlines;
  final TextInputType? keyboardType;

  CustomTextformfield({
    Key? key,
    required this.label,
    this.controller,
    this.obscureText = false,
    this.cellMask = false,
    this.validator,
    this.onChange,
    this.maxlines = 1,
    this.minlines = 1,
    this.keyboardType,
  }) : super(key: key);

  var maskFormatter = MaskTextInputFormatter(
      mask: '(##) #####-####',
      filter: {"#": RegExp(r'[0-9]')},
      type: MaskAutoCompletionType.lazy);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      inputFormatters: cellMask ? [maskFormatter] : [],
      controller: controller,
      obscureText: obscureText,
      validator: validator,
      onChanged: onChange,
      cursorColor: context.theme.primaryColor,
      decoration: InputDecoration(
        isDense: true,
        labelText: label,
        labelStyle: const TextStyle(color: Colors.black),
        errorStyle: const TextStyle(color: Colors.redAccent),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(23),
          borderSide: BorderSide(color: Colors.grey[400]!),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(23),
          borderSide: BorderSide(color: Colors.grey[400]!),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(23),
          borderSide: BorderSide(color: Colors.grey[400]!),
        ),
        filled: true,
        fillColor: Colors.white,
      ),
      maxLines: maxlines,
      minLines: minlines,
      keyboardType: keyboardType,
    );
  }
}
