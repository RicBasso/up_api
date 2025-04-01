import 'package:flutter/material.dart';

class InputWidget extends StatefulWidget {
  const InputWidget({
    super.key,
    this.onChange,
    this.onSubmitted,
    this.password = false,
    this.controller,
    this.hintText,
    this.fillColor = Colors.transparent,
    this.errorText,
  });

  final void Function(String)? onChange;
  final void Function(String)? onSubmitted;
  final bool password;
  final TextEditingController? controller;
  final String? hintText;
  final Color fillColor;
  final String? errorText;

  @override
  State<InputWidget> createState() => _InputWidgetState();
}

class _InputWidgetState extends State<InputWidget> {
  bool _obscureText = false;
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _obscureText = widget.password;
    _controller = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: TextField(
        controller: widget.controller ?? _controller,
        obscureText: _obscureText,
        onChanged: widget.onChange,
        onSubmitted: widget.onSubmitted,

        //textInputAction: TextInputAction.continueAction,
        decoration: InputDecoration(
          errorText: widget.errorText,
          fillColor: widget.fillColor,
          filled: true,
          hintText: widget.hintText,
          hintStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
          suffixIcon:
              widget.password == true
                  ? IconButton(
                    splashRadius: 1,
                    icon: Icon(
                      _obscureText ? Icons.visibility : Icons.visibility_off,
                      size: 16,
                    ),
                    onPressed:
                        () => setState(() => _obscureText = !_obscureText),
                  )
                  : null,
          //isDense: true,
        ),
      ),
    );
  }
}
