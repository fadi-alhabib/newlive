import 'package:flutter/material.dart';

class MyTextField {
  Widget build(BuildContext context,
      {Widget? suffix,
      Widget? lable,
      TextInputType? keyboardType,
      String? hint,
      TextEditingController? controller,
      String? Function(String?)? validator,
      Function()? onTap,
      bool? expands,
      void Function(String)? onChanged,
      bool? isSecure}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 7, horizontal: 7),
      child: TextFormField(
        onChanged: onChanged,
        expands: expands ?? false,
        onTap: onTap,
        maxLines: (expands ?? false) ? null : 1,
        minLines: null,
        keyboardType: keyboardType,
        controller: controller,
        validator: validator,
        obscureText: isSecure ?? false,
        decoration: InputDecoration(
            label: lable,
            hintText: hint,
            suffixIcon: suffix,
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(15))),
      ),
    );
  }
}
