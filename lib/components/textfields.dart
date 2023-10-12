import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CurrencyTextField extends StatelessWidget {
  final TextEditingController controller;
  final String labelText;
  final String prefix;
  final Function actionChange;
  final Function clearFunction;

  const CurrencyTextField({
    Key? key,
    required this.controller,
    required this.actionChange,
    required this.labelText,
    required this.clearFunction,
    this.prefix = '\$',
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      textAlign: TextAlign.right,
      style: inputStyle(),
      keyboardType: const TextInputType.numberWithOptions(
        decimal: true,
      ),
      inputFormatters: [
        FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}')),
      ],
      decoration: InputDecoration(
        labelText: labelText,
        labelStyle: labelStyle(),
        prefixText: prefix,
        suffixIcon: IconButton(
          onPressed: () => clearFunction(),
          icon: const Icon(Icons.clear),
          color: Colors.white,
        ),
      ),
      onChanged: (String value) => actionChange(value),
    );
  }

  TextStyle inputStyle() {
    return const TextStyle(
      color: Colors.white,
      fontSize: 20,
      fontWeight: FontWeight.bold,
    );
  }

  TextStyle labelStyle() {
    return TextStyle(color: Colors.amber.shade400);
  }
}
