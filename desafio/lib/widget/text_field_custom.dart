import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TextFieldCustom extends StatelessWidget {
  final TextEditingController? controller;
  final void Function(String)? onChanged;
  final List<TextInputFormatter>? inputFormatters;
  final String? prefixText;
  final double width;
  final TextInputType? textInputType;
  final String? initialValue;
  final String? hintText;
  final String? suffixText;

  const TextFieldCustom({
    Key? key,
    this.controller,
    this.onChanged,
    this.inputFormatters,
    this.prefixText,
    this.textInputType,
    this.initialValue,
    this.hintText,
    this.suffixText,
    this.width = 150,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: TextFormField(
        initialValue: initialValue,
        controller: controller,
        onChanged: onChanged,
        keyboardType: textInputType,
        inputFormatters: inputFormatters,
        textAlign: TextAlign.center,
        decoration: InputDecoration(
          border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(50)),
            borderSide: BorderSide(color: Colors.black),
          ),
          enabledBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(50)),
            borderSide: BorderSide(color: Color(0xFF3398FE)),
          ),
          focusedBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(50)),
            borderSide: BorderSide(color: Color(0xFFFEBF00)),
          ),
          prefixText: prefixText,
          hintText: hintText,
          suffixText: suffixText,
        ),
      ),
    );
  }
}
