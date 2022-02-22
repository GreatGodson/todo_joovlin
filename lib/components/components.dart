import 'package:flutter/material.dart';

class TextFieldWidget extends StatelessWidget {
  final double width;
  final double height;
  final String hintText;

  final Function(String) onChanged;
  const TextFieldWidget(
      {Key? key,
      required this.width,
      required this.height,
      required this.hintText,
      required this.onChanged})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0),
        color: const Color.fromRGBO(245, 245, 245, 1),
        border: Border.all(
          color: const Color.fromRGBO(245, 245, 245, 1),
        ),
      ),
      child: TextField(
        onChanged: onChanged,
        style: const TextStyle(
          color: Color.fromRGBO(6, 5, 27, 1),
          fontFamily: 'Helvetica',
          fontSize: 14.0,
          fontWeight: FontWeight.w400,
        ),
        decoration: InputDecoration(
          border: InputBorder.none,
          fillColor: const Color.fromRGBO(245, 245, 245, 1),
          hintText: hintText,
          contentPadding: const EdgeInsets.only(left: 16.0),
          hintStyle: const TextStyle(
              fontSize: 14.0,
              color: Color.fromRGBO(167, 166, 180, 1),
              fontWeight: FontWeight.w400,
              fontFamily: 'Helvetica'),
          focusedBorder: OutlineInputBorder(
              borderSide:
                  const BorderSide(color: Color.fromRGBO(245, 245, 245, 1)),
              borderRadius: BorderRadius.circular(10.0)),
        ),
      ),
    );
  }
}
