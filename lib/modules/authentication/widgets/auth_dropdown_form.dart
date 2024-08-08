import 'package:flutter/material.dart';

class AuthDropdownForm extends StatefulWidget {
  const AuthDropdownForm({
    super.key,
    required this.dropdownKey,
    required this.onTap,
    required this.items,
    required this.onChanged,
    required this.value,
    required this.hint,
    required this.validator,
    required this.isLoading,
    required this.isError,
    required this.prefixIcon,
  });
  final Function() onTap;
  final GlobalKey<FormFieldState> dropdownKey;
  final List<DropdownMenuItem> items;
  final ValueChanged onChanged;
  final value;
  final Widget hint;
  final String? Function(dynamic)? validator;
  final bool isLoading;
  final bool isError;
  final IconData prefixIcon;

  @override
  State<AuthDropdownForm> createState() => _AuthDropdownFormState();
}

class _AuthDropdownFormState extends State<AuthDropdownForm> {

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: Colors.blueGrey[700],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 10.0),
            child: Icon(
              widget.prefixIcon,
              color: Colors.white,
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: DropdownButtonFormField(
              key: widget.dropdownKey,
              dropdownColor: Colors.blueGrey[700],
              items: widget.items,
              onChanged: widget.onChanged,
              value: widget.value,
              hint: widget.hint,
              validator: widget.validator,
              icon: Padding(
                padding: EdgeInsets.only(
                    right: 10.0,
                    bottom: widget.isLoading ? 0 : 5
                ),
                child: SizedBox(
                  width: 20,
                  height: 20,
                  child: widget.isLoading ?
                  CircularProgressIndicator(
                    strokeWidth: 2,
                    color: Colors.blueGrey[200],
                  )
                      : widget.isError ? InkWell(
                      child: Icon(Icons.refresh, color: Colors.blueGrey[200]),
                      onTap: () {
                        widget.onTap();
                      })
                      : Icon(
                      Icons.arrow_drop_down,
                      color: Colors.blueGrey[200]
                  ),
                )
              ),
              decoration: const InputDecoration(
                border: InputBorder.none,
                errorStyle: TextStyle(
                    color: Colors.transparent,
                    fontSize: 0
                ),
              ),
              style: const TextStyle(
                color: Colors.white,
                fontSize: 14,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
