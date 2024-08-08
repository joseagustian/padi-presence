import 'package:flutter/material.dart';

class CreateSubmissionDropdownForm extends StatefulWidget {
  const CreateSubmissionDropdownForm({
    super.key,
    required this.dropdownKey,
    required this.items,
    required this.onChanged,
    required this.value,
    required this.hint,
    required this.validator,
    required this.prefixIcon,
  });

  final GlobalKey<FormFieldState> dropdownKey;
  final List<DropdownMenuItem> items;
  final ValueChanged onChanged;
  final value;
  final Widget hint;
  final String? Function(dynamic)? validator;
  final IconData prefixIcon;

  @override
  State<CreateSubmissionDropdownForm> createState() => _CreateSubmissionDropdownForm();
}

class _CreateSubmissionDropdownForm extends State<CreateSubmissionDropdownForm> {

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
            padding: const EdgeInsets.only(left: 15.0),
            child: Icon(
              widget.prefixIcon,
              color: Colors.white,
              size: 18,
            ),
          ),
          const SizedBox(width: 15),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(right: 10.0),
              child: DropdownButtonFormField(
                isExpanded: true,
                key: widget.dropdownKey,
                dropdownColor: Colors.blueGrey[700],
                items: widget.items,
                onChanged: widget.onChanged,
                value: widget.value,
                hint: widget.hint,
                validator: widget.validator,
                icon: Padding(
                  padding: const EdgeInsets.only(right: 3.0),
                  child: Icon(
                    Icons.arrow_drop_down,
                    color: Colors.blueGrey[200],
                    size: 18,
                  ),
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
                  fontFamily: 'Lato',
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
