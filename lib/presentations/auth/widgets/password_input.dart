import 'package:flutter/material.dart';

class PasswordTextFormField extends StatefulWidget {
  PasswordTextFormField({
    super.key,
    required this.passwordController,
  });

  final TextEditingController passwordController;

  @override
  State<PasswordTextFormField> createState() => _PasswordTextFormFieldState();
}

class _PasswordTextFormFieldState extends State<PasswordTextFormField> {
  bool showPassword = false;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.passwordController,
      validator: (val) {
        return val?.isEmpty ?? true ? 'Invalid password format' : null;
      },
      obscureText: showPassword ? false : true,
      enableSuggestions: false,
      autocorrect: false,
      decoration: InputDecoration(
          suffixIcon: GestureDetector(
              onTap: () => setState(() => showPassword = !showPassword),
              child:
                  Icon(showPassword ? Icons.visibility_off : Icons.visibility)),
          hintText: 'Password',
          hintStyle: const TextStyle(fontWeight: FontWeight.w300),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(15))),
    );
  }
}
