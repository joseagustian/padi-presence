import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:padi/core/constants/strings.dart';
import 'package:padi/modules/shared/presenters/captcha_dialog/validators/validate_captcha_form.dart';

import 'captcha_generator_provider.dart';

class CaptchaAlertDialog extends ConsumerStatefulWidget {
  const CaptchaAlertDialog({
    super.key,
    required this.onPassed,
  });
  final void Function() onPassed;

  @override
  ConsumerState<CaptchaAlertDialog> createState() => _CaptchaAlertDialogState();
}

class _CaptchaAlertDialogState extends ConsumerState<CaptchaAlertDialog> {
  final TextEditingController _captchaController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final state = ref.watch(captchaProvider);
    return AlertDialog(
      contentPadding: const EdgeInsets.all(20.0),
      content: ConstrainedBox(
        constraints: BoxConstraints(
          minHeight: MediaQuery.of(context).size.height * 0.3,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              Strings.captcha,
              style: TextStyle(
                  color: Colors.blueGrey[900],
                  fontSize: 20,
                  fontWeight: FontWeight.bold
              ),
            ),
            const Text(
              Strings.verificationToContinue,
              style: TextStyle(
                  color: Colors.blueGrey,
                  fontSize: 14,
                  fontWeight: FontWeight.bold
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Container(
                    height: 45,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(
                            color: Colors.blueGrey[900]!,
                            width: 2
                        ),
                        color: Colors.transparent
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Text(
                        state.captcha.toString(),
                        style: TextStyle(
                            color: Colors.blueGrey[900],
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 8,
                            decoration: TextDecoration.lineThrough
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 5),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blueGrey[900],
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5)
                      ),
                      minimumSize: const Size(40, 45)
                  ),
                  onPressed: () {
                    ref.read(captchaProvider.notifier).refreshCaptcha();
                  },
                  child: const Padding(
                    padding: EdgeInsets.symmetric(vertical: 8.0),
                    child: Icon(
                      Icons.refresh,
                      color: Colors.white,
                    ),
                  ),
                )
              ],
            ),
            const SizedBox(height: 5),
            LinearProgressIndicator(
              value: state.remainingTime,
              backgroundColor: Colors.blueGrey[500],
              color: Colors.blueGrey[900],
            ),
            const SizedBox(height: 10),
            Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: Colors.blueGrey[700],
                ),
                child: TextFormField(
                  textAlignVertical: TextAlignVertical.center,
                  textAlign: TextAlign.start,
                  controller: _captchaController,
                  keyboardType: TextInputType.number,
                  cursorColor: Colors.white,
                  style: const TextStyle(
                    color: Colors.white,
                    fontFamily: 'Lato',
                    fontSize: 14,
                  ),
                  inputFormatters: [
                    LengthLimitingTextInputFormatter(4),
                    FilteringTextInputFormatter.digitsOnly
                  ],
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    prefixIcon: Icon(
                      Icons.verified_user,
                      color: Colors.white,
                    ),
                    hintText: Strings.inputCaptcha,
                    hintStyle: TextStyle(
                        color: Colors.white,
                        fontFamily: 'Lato',
                        fontSize: 14
                    ),
                    errorStyle: TextStyle(
                        color: Colors.transparent,
                        fontSize: 0
                    ),
                  ),
                )
            ),
            const SizedBox(height: 30),
            Row(
              children: [
                Expanded(
                  child: SizedBox(
                    height: 45,
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blueGrey[900],
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5)
                          ),
                        ),
                        onPressed: () {
                          validateCaptchaForm(
                            _captchaController,
                            state.captcha,
                            context,
                                () { widget.onPassed(); },
                          );
                        },
                        child: const Padding(
                          padding: EdgeInsets.symmetric(vertical: 8.0),
                          child: Text(
                            Strings.verify,
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                                fontWeight: FontWeight.bold
                            ),
                          ),
                        )
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      )
    );
  }
}

void showCaptchaAlertDialog(
    BuildContext context,
    void Function() onPassed
    ) {
  showDialog(
      context: context,
      builder: (context) {
        return CaptchaAlertDialog(
          onPassed: onPassed,
        );
      }
  );
}
