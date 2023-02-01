import 'package:flutter/material.dart';

class SharedFormField extends StatelessWidget {
  const SharedFormField({
    Key? key,
    this.controller,
    this.text,
    this.validator,
  }) : super(key: key);

  final TextEditingController? controller;
  final String? text;
  final String? Function(String?)? validator;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.7),
        borderRadius: const BorderRadius.all(
          Radius.circular(20),
        ),
      ),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          hintText: text,
          border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(20),
            ),
          ),
        ),
        validator: validator,
      ),
    );
  }
}
