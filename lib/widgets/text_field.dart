import 'package:flutter/material.dart';

class TextFields extends StatelessWidget {
  const TextFields({super.key,required this.label,required this.hint,required this.helper,this.obscure = false,this.keyboardType = TextInputType.text});
  final String label;
  final String hint;
  final String helper;
  final bool obscure;
  final TextInputType keyboardType;

  @override
  Widget build(BuildContext context) {
    final textCtrl = TextEditingController();

    return  TextField(
                controller: textCtrl,
                obscureText: true,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  label: Text('Name1'),
                  border: OutlineInputBorder(),
                  focusColor: Theme.of(context).colorScheme.inversePrimary,
                  helperText: "It's necesary your full name",
                  hintText: 'John Doe',
                ),
              );
  }
}
