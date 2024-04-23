import 'package:action_slider/action_slider.dart';
import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:padi/core/constants/strings.dart';

class ConfirmLogoutDialog extends StatefulWidget {
  final void Function() onConfirm;
  const ConfirmLogoutDialog({
    super.key,
    required this.onConfirm,
  });

  @override
  State<ConfirmLogoutDialog> createState() => _ConfirmLogoutDialogState();
}

class _ConfirmLogoutDialogState extends State<ConfirmLogoutDialog> {
  final _controller = ActionSliderController();
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      contentPadding: const EdgeInsets.all(20.0),
      content: ConstrainedBox(
        constraints: BoxConstraints(
          maxHeight: MediaQuery.of(context).size.height * 0.15,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              Strings.confirm,
              style: TextStyle(
                  color: Colors.blueGrey[900],
                  fontSize: 20,
                  fontWeight: FontWeight.bold
              ),
            ),
            const Text(
              Strings.slideToLogout,
              style: TextStyle(
                  color: Colors.blueGrey,
                  fontSize: 14,
                  fontWeight: FontWeight.bold
              ),
            ),
            const Expanded(child: SizedBox(height: 10)),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.8,
              height: 45,
              child: ActionSlider.custom(
                controller: _controller,
                height: 45,
                sliderBehavior: SliderBehavior.stretch,
                backgroundColor: Colors.blueGrey.shade800,
                backgroundBorderRadius: BorderRadius.circular(5),
                foregroundBuilder: (context, foreground, background) {
                  return Container(
                    height: 45,
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    alignment: Alignment.centerRight,
                    decoration: BoxDecoration(
                      color: Colors.blueGrey.shade400,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: const Icon(
                      BoxIcons.bx_exit,
                      color: Colors.white,
                      size: 30,
                    )
                  );
                },
                action: (controller) async {
                  widget.onConfirm();
                  controller.reset();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

void showConfirmLogoutDialog(BuildContext context, void Function() onConfirm) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return ConfirmLogoutDialog(
        onConfirm: onConfirm,
      );
    },
  );
}
