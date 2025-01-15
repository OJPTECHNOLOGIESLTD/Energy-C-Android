import 'package:energy_chleen/utils/Helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ReuseableTextformfield extends StatefulWidget {
  final String topTitle;
  final String hintText;
  final bool isPasswordField;
  final TextInputType keyboardType;
  final String? Function(String?)? validator;
  final void Function(String)? onChanged;

  const ReuseableTextformfield({
    Key? key,
    required this.topTitle,
    required this.hintText,
    this.isPasswordField = false,
    this.keyboardType = TextInputType.text,
    this.validator,
    this.onChanged,
  }) : super(key: key);

  @override
  State<ReuseableTextformfield> createState() => _ReuseableTextformfieldState();
}

class _ReuseableTextformfieldState extends State<ReuseableTextformfield> {
  bool _obscurePassword = true;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.topTitle,
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold,color: Customcolors.white),
          ),
          SizedBox(height: 8),
          TextFormField(
            obscureText: widget.isPasswordField ? _obscurePassword : false,
            keyboardType: widget.keyboardType,
            validator: widget.validator,
            onChanged: widget.onChanged,
            decoration: InputDecoration(
              filled: true, // To fill the background color
              fillColor: Colors.white, // White background color
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0),
                borderSide: BorderSide(color: Colors.white), // White border color
              ),
              hintText: widget.hintText,
              hintStyle: TextStyle(color: Colors.grey),
              suffixIcon: widget.isPasswordField
                  ? IconButton(
                      onPressed: () {
                        setState(() {
                          _obscurePassword = !_obscurePassword;
                        });
                      },
                      icon: Icon(
                        _obscurePassword
                            ? CupertinoIcons.eye_slash
                            : CupertinoIcons.eye,
                        color: Colors.black,
                      ),
                    )
                  : null,
            ),
          ),
        ],
      ),
    );
  }
}
