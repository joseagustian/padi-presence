import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CorrectionProgressTypeRadioButton extends ConsumerWidget {
  final String title;
  final Enum groupValue;
  final Enum value;
  final AutoDisposeStateProvider provider;
  final void Function() onChanged;
  final bool enabled;
  const CorrectionProgressTypeRadioButton({
    super.key,
    required this.title,
    required this.groupValue,
    required this.value,
    required this.provider,
    required this.onChanged,
    required this.enabled
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Row(
    children: [
      Radio<Enum>(
        visualDensity: const VisualDensity(
            vertical: -4.0,
            horizontal: -4.0
        ),
        value: value,
        activeColor: Colors.blueGrey.shade700,
        groupValue: groupValue,
        onChanged: enabled ? (Enum? value) {
          ref.read(provider.notifier).state = value;
          onChanged();
        } : null,
      ),
      Text(
        title,
        style: TextStyle(
          fontSize: 14.0,
          fontWeight: FontWeight.bold,
          color: enabled ? Colors.blueGrey.shade700 : Colors.grey,
        ),
      ),
    ],
    );
  }
}
